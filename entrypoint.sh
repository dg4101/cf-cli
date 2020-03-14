#!/bin/sh -l
pwd
echo git version
git --version
echo yarn version
yarn --version
echo node version
node --version
echo npm version
npm --version

cd ./covid19
pwd

git checkout dev-scp
find . |grep cf
echo ====================
cf --version

cf api "$INPUT_CF_API"
cf auth "$INPUT_CF_USERNAME" "$INPUT_CF_PASSWORD"

if [ -n "$INPUT_CF_ORG" ] && [ -n "$INPUT_CF_SPACE" ]; then
  cf target -o "$INPUT_CF_ORG" -s "$INPUT_CF_SPACE"
fi

cd /tmg
mv ./covid19/cf/manifest.yaml ./

cf push stopcovid19 -f manifest.yaml -p covid19 -c "yarn dev"
