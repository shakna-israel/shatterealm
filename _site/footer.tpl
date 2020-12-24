<footer>
<hr />
<ul>
{% for index, v in pairs(toc) do %}
{% if v.name ~= "All Posts" then %}

{%
	local descriptor
	local long_descriptor
	if v.description then
		descriptor = v.description
		long_descriptor = v.description
	elseif v.value then
		descriptor = v.value:sub(1, 50) .. '...'
		long_descriptor = markdown(iformat(v.value:sub(1, 150) .. '...', _G or {}))
	else
		descriptor = v.title or v.name or '...'
		long_descriptor = false
	end
%}

{% if v.directory then %}
{%
	local last_num = v.sortname:match('^.*()%d')
	local date_section = v.sortname:sub(1, last_num)
	local word_section = v.sortname:sub(last_num + 1)

	date_section = date_section:gsub(" ", "-")

	local name = word_section .. ' [' .. v.directory .. ']' .. ' (' .. date_section .. ')'
%}
<li>
	<a href="{{v.path}}" title="{{descriptor}}">{{name}}</a>
	{% if long_descriptor then %}
	<details><summary>Preview</summary>{{long_descriptor}}</details>
	{% end %}
</li>
{% else %}
<li>
	<a href="{{v.path}}" title="{{descriptor}}">{{v.name}}</a>
	{% if long_descriptor then %}
	<details><summary>Preview</summary>{{long_descriptor}}</details>
	{% end %}
</li>
{% end %}
{%
	-- TODO: Instead, we should wrap them up in a details field with "More" as the summary...
	if index > 7 then break end
%}
{% end %}
{% end %}
<li><a href="{{(base_url or '/') .. 'all.html'}}" title="All Posts">All Posts</a></li>
<li><a href="{{(base_url or '/') .. 'feed.xml'}}" title="RSS Feed">RSS Feed</a></li>
</ul>
</footer>
