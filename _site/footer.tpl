<footer>
<hr />
<ul>
{% for index, v in pairs(toc) do %}
{% if v.name ~= "All Posts" then %}

{%
	local descriptor
	if v.description then
		descriptor = v.description
	elseif v.value then
		descriptor = v.value:sub(1, 50) .. '...'
	else
		descriptor = v.title or v.name or '...'
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
</li>
{% else %}
<li>
	<a href="{{v.path}}" title="{{descriptor}}">{{v.name}}</a>
</li>
{% end %}

{% if index == 8 then %}
<details>
<summary>More</summary>
{% end %}

{% end %}
{% end %}

{% if #toc > 7 then %}
</details>
{% end %}

<li><a href="{{(base_url or '/') .. 'all.html'}}" title="All Posts">All Posts</a></li>
<li><a href="{{(base_url or '/') .. 'feed.xml'}}" title="RSS Feed">RSS Feed</a></li>
</ul>

{% if config.copyright then %}
<small>&copy; {{date("%Y")}} All Rights Reserved, {{config.copyright}}</small>
{% end %}
</footer>
