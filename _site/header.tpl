<!doctype html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

{% if title then %}
<title>{{ title }} | Shatterealm</title>
{% else %}
<title>Shatterealm</title>
{% end %}

<link rel="stylesheet" href="{{(base_url or '/') .. 'styles.css'}}" />

<link rel="alternate" type="application/rss+xml" title="Shatterealm RSS" href="{{(base_url or '/') .. 'feed.xml'}}"/>
</head>
<body>

<a href="{{ base_url or '/' }}">Home</a>

{% if title then %}
<h1>{{title}}</h1>
{% end %}

{% if subtitle then %}
<h2>{{subtitle}}</h2>
{% end %}
