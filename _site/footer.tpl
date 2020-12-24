<footer>
<hr />
<ul>
{% for index, v in pairs(toc) do %}
{% if v.name ~= "All Posts" then %}
<li><a href="{{v.path}}">{{v.name}}</a></li>
{% if index > 7 then break end %}
{% end %}
{% end %}
<li><a href="{{(base_url or '/') .. 'all.html'}}">All Posts</a></li>
<li><a href="{{(base_url or '/') .. 'feed.xml'}}">RSS Feed</a></li>
</ul>
</footer>
