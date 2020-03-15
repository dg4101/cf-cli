#!/bin/sh -l

cd /tmg
pwd

git clone "$INPUT_GIT_REPO"

cd /tmg/covid19

echo ====================
git checkout dev-scp
find . |grep cf
mv ./cf/manifest-html.yaml /tmg/

git checkout production
find . |grep index.html
zip -r production.zip ./

echo ====================
cf --version

cf api "$INPUT_CF_API"
cf auth "$INPUT_CF_USERNAME" "$INPUT_CF_PASSWORD"

if [ -n "$INPUT_CF_ORG" ] && [ -n "$INPUT_CF_SPACE" ]; then
  cf target -o "$INPUT_CF_ORG" -s "$INPUT_CF_SPACE"
fi

cf push stopcovid19-1 -p /tmg/covid19/production.zip -f /tmg/manifest-html.yaml
