{{ include(site_directory .. '/header.tpl', {toc=toc, subtitle=subtitle, title=title}) }}

{{ markdown(value) }}

{{ include(site_directory .. '/footer.tpl', {toc=toc}) }}
