<!doctype html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

{% if title then %}
<title>{{ title }} | {{ config.site_name or ''}}</title>
{% else %}
<title>{{ config.site_name or ''}}</title>
{% end %}

<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta http-equiv="Referrer-Policy" content="no-referrer">
<meta http-equiv="Cache-Control" content="public, max-age=604800, no-cache, immutable">
<meta http-equiv="X-Content-Type-Options" content="nosniff">
<meta http-equiv="X-Frame-Options" content="deny">
<meta http-equiv="X-XSS-Protection" content="1; mode=block">

<meta http-equiv="Strict-Transport-Security" content="max-age=15768000; preload">

<meta http-equiv="Content-Security-Policy" content="default-src 'self'">
<meta http-equiv="X-Content-Security-Policy" content="default-src 'self'">
<meta http-equiv="X-WebKit-CSP" content="default-src 'self'">

<link rel="stylesheet" href="{{(base_url or '/') .. 'styles.css'}}" />
<link rel="alternate" type="application/rss+xml" title="{{ (config.site_name or '') .. ' RSS'}}" href="{{(base_url or '/') .. 'feed.xml'}}"/>

<link rel="apple-touch-icon" sizes="180x180" href="{{(base_url or '/') .. 'apple-touch-icon.png'}}">
<link rel="icon" type="image/png" sizes="32x32" href="{{(base_url or '/') .. 'favicon-32x32.png'}}">
<link rel="icon" type="image/png" sizes="16x16" href="{{(base_url or '/') .. 'favicon-16x16.png'}}">
<link rel="manifest" href="{{(base_url or '/') .. 'site.webmanifest'}}">

<meta name="generator" content="suckgen">
<meta name="rating" content="General">
<meta name="referrer" content="no-referrer">
<meta name="description" content="{{config.description or ''}}">
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
