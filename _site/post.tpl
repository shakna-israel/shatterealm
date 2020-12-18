{{ include(site_directory .. '/header.tpl', {subtitle=subtitle, title=title}) }}

<article>
{{ markdown(value) }}
</article>

{{ include(site_directory .. '/footer.tpl', {toc=toc}) }}
