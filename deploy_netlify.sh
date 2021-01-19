#!/bin/sh

set -e

. ~/auth_file

# If we've got auth, build a JSON file with comment data...
if [ -n "${srauth}" ]; then
	env srauth="${srauth}" python3 build_comments.py
fi

cd _build/
zip -q -r ../website.zip .
cd ..

curl -s -H "Content-Type: application/zip" \
     -H "Authorization: Bearer ${auth}" \
     --data-binary "@website.zip" \
     https://api.netlify.com/api/v1/sites/shatterealm.netlify.app/deploys \
> /dev/null
