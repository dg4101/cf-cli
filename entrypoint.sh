#!/bin/sh -l
pwd
git --version
echo ====================
yarn --version
git clone https://github.com/dg4101/covid19.git
cd ./covid19
yarn dev
git checkout dev-scp

find . |grep cf
echo ====================
cf --version

cf api "$INPUT_CF_API"
cf auth "$INPUT_CF_USERNAME" "$INPUT_CF_PASSWORD"

if [ -n "$INPUT_CF_ORG" ] && [ -n "$INPUT_CF_SPACE" ]; then
  cf target -o "$INPUT_CF_ORG" -s "$INPUT_CF_SPACE"
fi

cd ..
mv ./covid19/cf/manifest.yaml ./

pwd
cf push stopcovid19 -f manifest.yaml -p covid19 -c "yarn dev"
