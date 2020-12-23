{{ include(site_directory .. '/header.tpl', {subtitle=subtitle, title=title}) }}

{%
	--[[

	`value` can be either a string for Markdown, or an array of strings for Markdown.

	]]
%}

{% if type(value) == 'string' then %}
<article>
{{ markdown(iformat(value, _G)) }}
</article>
{% elseif type(value) == 'table' then %}
<article>
{% for index, text in ipairs(value) do %}
{{ markdown(iformat(text, _G)) }}
{% end %}
</article>
{% end %}

{{ include(site_directory .. '/footer.tpl', {toc=toc}) }}
