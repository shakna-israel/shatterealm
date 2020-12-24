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
		descriptor = '...'
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
<li><a href="{{v.path}}" title="{{descriptor}}">{{name}}</a></li>
{% else %}
<li><a href="{{v.path}}" title="{{descriptor}}">{{v.name}}</a></li>
{% end %}
{% if index > 7 then break end %}
{% end %}
{% end %}
<li><a href="{{(base_url or '/') .. 'all.html'}}">All Posts</a></li>
<li><a href="{{(base_url or '/') .. 'feed.xml'}}">RSS Feed</a></li>
</ul>
</footer>
