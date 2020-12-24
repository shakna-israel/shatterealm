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

	wpm = format("%.2f", 220 / word_n)
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

{{ include(site_directory .. '/footer.tpl', {toc=toc}) }}
