<!doctype html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

{% if title then %}
<title>{{ title }} | {{ config.site_name or ''}}</title>
{% else %}
<title>{{ config.site_name or ''}}</title>
{% end %}

<link rel="stylesheet" href="{{(base_url or '/') .. 'styles.css'}}" />
<link rel="alternate" type="application/rss+xml" title="{{ (config.site_name or '') .. ' RSS'}}" href="{{(base_url or '/') .. 'feed.xml'}}"/>

<link rel="apple-touch-icon" sizes="180x180" href="{{(base_url or '/') .. 'apple-touch-icon.png'}}">
<link rel="icon" type="image/png" sizes="32x32" href="{{(base_url or '/') .. 'favicon-32x32.png'}}">
<link rel="icon" type="image/png" sizes="16x16" href="{{(base_url or '/') .. 'favicon-16x16.png'}}">
<link rel="manifest" href="{{(base_url or '/') .. 'site.webmanifest'}}">
</head>
<body>

<a href="{{ base_url or '/' }}">Home</a>
<hr />

{% if title then %}
<h1>{{title}}</h1>
{% end %}

{% if subtitle then %}
<h2>{{subtitle}}</h2>
{% end %}
