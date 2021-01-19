{{ include(site_directory .. '/header.tpl', {subtitle=subtitle, title=title}) }}

{%
	--[[

	`value` can be either a string for Markdown, or an array of strings for Markdown.

	]]

	local word_n = 0

	if type(value) == 'string' then
		_, word_n = value:gsub("%S+","")
	elseif type(value) == 'table' then
		for index, text in ipairs(value) do
			_, text_n = value:gsub("%S+","")
			word_n = word_n + text_n
		end
	end

	wpm = format("%.2f", word_n / 220)
%}

{% if type(value) == 'string' then %}
<article>
<p>Estimated Reading Time: {{wpm}} minutes.</p>

{{ markdown(iformat(value, _G or {})) }}
</article>
{% elseif type(value) == 'table' then %}
<article>
<p>Estimated Reading Time: {{wpm}}/minutes</p>

{% for index, text in ipairs(value) do %}
{{ markdown(iformat(text, _G or {})) }}
{% end %}
</article>
{% end %}

<hr>
<h3>Comments</h3>
<div id="comments"></div>
<script>
window.addEventListener('load', function() {
	fetch("/comments.json")
	  .then(function(response) {
	  	return response.json();
	  })
	  .then(function(data) {
	  	var comments = data['{{substring(rootfile or '', #config.site_directory + 1)}}'];
	  	if(!!comments) {
	  		var el = document.getElementById("comments");

	  		for(var i = 0; i < comments.length; i++) {
	  			var child_container = document.createElement('blockquote');
	  			child_container.classList.add('comment');

	  			var child_content = document.createElement('p');
	  			child_content.textContent = comments[i]['content'];
	  			child_container.appendChild(child_content);

	  			var child_attribution = document.createElement('p');
	  			var child_attribution_inner = document.createElement('em');
	  			child_attribution_inner.textContent = comments[i]['user'];
	  			child_attribution.appendChild(child_attribution_inner);
	  			child_container.appendChild(child_attribution);

	  			el.appendChild(child_container);
	  		}
	  	}
	  })
	  .catch(function(err) {
	  	console.log(err);
	  });
});
</script>
<noscript>
<p><a href="https://todo.sr.ht/~shakna/shatterealm">See comments here.</a></p>
</noscript>

{{ include(site_directory .. '/footer.tpl', {toc=toc}) }}
