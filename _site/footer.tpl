<footer>
<ul>
{% for index, v in pairs(toc) do %}
<li><a href="{{v.path}}">{{v.name}}</a></li>
{% end %}
<li><a href="{{(base_url or '/') .. 'feed.xml'}}">RSS Feed</a></li>
</ul>
</footer>
