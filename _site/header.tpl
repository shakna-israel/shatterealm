<!doctype html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

{% if title then %}
<title>{{ title }} | Shatterealm</title>
{% else %}
<title>Shatterealm</title>
{% end %}

<link rel="stylesheet" href="{{base_url}}styles.css" />
</head>
<body>
{% if title then %}
<h1>{{title}}</h1>
{% end %}
