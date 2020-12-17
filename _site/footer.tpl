<ul>
{% for index, v in pairs(toc) do %}
<li><a href="{{v.path}}">{{v.name}}</a></li>
{% end %}
</ul>
