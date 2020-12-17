#!/bin/sh

set -e

cd _build/
zip -r ../website.zip .
cd ..

. ~/auth_file

curl -H "Content-Type: application/zip" \
     -H "Authorization: ${auth}" \
     --data-binary "@website.zip" \
     https://api.netlify.com/api/v1/sites/shatterealm.netlify.app/deploys
