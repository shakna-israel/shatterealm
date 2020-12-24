<footer>
<hr />
<ul>
{% for index, v in pairs(toc) do %}
{% if v.name ~= "All Posts" then %}
<li><a href="{{v.path}}">{{v.name}}</a></li>
{% end %}
{% if index > 10 then break end %}
{% end %}
<li><a href="{{(base_url or '/') .. 'all.html'}}">All Posts</a></li>
<li><a href="{{(base_url or '/') .. 'feed.xml'}}">RSS Feed</a></li>
</ul>
</footer>
