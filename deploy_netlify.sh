#!/bin/sh

set -e

cd _build/
zip -q -r ../website.zip .
cd ..

. ~/auth_file

curl -s -H "Content-Type: application/zip" \
     -H "Authorization: Bearer ${auth}" \
     --data-binary "@website.zip" \
     https://api.netlify.com/api/v1/sites/shatterealm.netlify.app/deploys \
> /dev/null
