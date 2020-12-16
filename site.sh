#!/bin/sh

set -e

# Copyright 2020 James Milne
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Load a config if we have one
if [ -r ./config.sh ]; then
	. ./config.sh
fi

# Get default values
if [ -z "${site_dir}" ]; then
	site_dir='_site'
fi
if [ -z "${build_dir}" ]; then
	build_dir='_build'
fi
if [ -z "${base_url}" ]; then
	base_url='/'
fi

# Clean the build directory...
if [ -d "${build_dir}" ]; then
	rm -rf "${build_dir}"
fi

# Get length of site_dir
site_dir_length=$(($(echo "${site_dir}" | wc -c) - 1))
# Get length of build_dir
build_dir_length=$(($(echo "${build_dir}" | wc -c) - 1))

# Get files to render...
file_list="$(mktemp)"
find "$site_dir" -name '*.md' | sort > "${file_list}"

# Start rendering...
mkdir -p "${build_dir}"

while read -r line; do
	# Remove the site_dir...
	base_path="$(echo "${line}" | sed 's/\(.\{'"${site_dir_length}"'\}\)//')"
	# Set the output path...
	output_path="$(echo "${build_dir}${base_path%.md}.html")"

	# Check if this is an index file, or if we should prettify it...
	fname="$(basename "${output_path}")"
	if [ "$fname" != 'index.html' ]; then
		output_path="$(dirname "${output_path}")/${fname%.html}/index.html"
	fi

	# Create the output folder...
	mkdir -p "$(dirname "${output_path}")"

	# Render the template file...
	template="$(cat ${line})"
	eval "echo \"${template}\"" \
	| pandoc -fmarkdown -thtml5 > "${output_path}"

	# Extras for functionality...
	echo '<noscript>JavaScript appears to be disabled. Some dynamic features may require it.</noscript>' >> "${output_path}"
	echo '<script>' >> "${output_path}"

	# Support include element
	echo 'window.addEventListener("load", function() {' >> "${output_path}"
	echo '	var els = document.querySelectorAll("include");' >> "${output_path}"
	echo '' >> "${output_path}"
	echo '	for(var i = 0; i < els.length; i++) {' >> "${output_path}"
	echo '		var fetch_uri = els[i].getAttribute("href");' >> "${output_path}"
	echo '		' >> "${output_path}"
	echo '		(function(el) {' >> "${output_path}"
	echo '			fetch(fetch_uri)' >> "${output_path}"
	echo '			  .then(response => {' >> "${output_path}"
	echo '			    return response.text()' >> "${output_path}"
	echo '			  })' >> "${output_path}"
	echo '			  .then(data => {' >> "${output_path}"
	echo '			    el.innerHTML = data;' >> "${output_path}"
	echo '			  });' >> "${output_path}"
	echo '		})(els[i]);' >> "${output_path}"
	echo '	}' >> "${output_path}"
	echo '});' >> "${output_path}"

	echo '</script>' >> "${output_path}"

done < "${file_list}"

# Find and copy non-templated files to the right places...
all_files="$(mktemp)"
find "$site_dir" -type f | sort > "${all_files}"

extra_files="$(mktemp)"
comm -13 "${file_list}" "${all_files}" | sort > "${extra_files}"

while read -r line; do
	# Remove the site_dir...
	base_path="$(echo "${line}" | sed 's/\(.\{'"${site_dir_length}"'\}\)//')"
	# Set the output path...
	output_path="$(echo "${build_dir}${base_path}")"

	# Copy the file
	cp "$line" "$output_path"
done < "$extra_files"

# Create navigation...
if [ -r "${site_dir}"/navigation.html ]; then
	# Do nothing already copied user-specified navigation.
	:
else
	# Generate some navigation...
	toc_files="$(mktemp)"
	find "${build_dir}" -name '*.html' | sort > "${toc_files}"

	toc_file="$(mktemp)"
	echo '<navigation><ul>' > "$toc_file"

	while read -r line; do
		# Remove the build_dir...
		base_path="$(echo "${line}" | sed 's/\(.\{'"${build_dir_length}"'\}\)//')"
		link_path="$(echo "${base_url}${base_path:1:-10}")"

		if [ "$link_path" = '/' ]; then
			link_name='Home'
		else
			link_name="$(basename "${link_path}" \
			  `# Title case the name:`\
			  | awk 'BEGIN{split("a the to at in on with and but or",w); for(i in w)nocap[w[i]]}function cap(word){return toupper(substr(word,1,1)) tolower(substr(word,2))}{for(i=1;i<=NF;++i){printf "%s%s",(i==1||i==NF||!(tolower($i) in nocap)?cap($i):tolower($i)),(i==NF?"\n":" ")}}' \
		  	)"
		fi

		echo "<li><a href='${link_path}'>${link_name}</a></li>" >> "${toc_file}"
	done < "$toc_files"
	echo '</ul></navigation>' >> "${toc_file}"
	# Push our navigation include...
	mv "${toc_file}" "${build_dir}/navigation.html"
fi

# Cleanup
rm "${file_list}"
rm "${all_files}"
rm "${toc_files}"
