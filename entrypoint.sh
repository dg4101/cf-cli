#!/bin/sh -l
pwd
git --version
git clone https://github.com/dg4101/covid19.git
#cd ./covid19
git checkout dev-scp

find . |grep cf
echo ====================
cf --version

cf api "$INPUT_CF_API"
cf auth "$INPUT_CF_USERNAME" "$INPUT_CF_PASSWORD"

if [ -n "$INPUT_CF_ORG" ] && [ -n "$INPUT_CF_SPACE" ]; then
  cf target -o "$INPUT_CF_ORG" -s "$INPUT_CF_SPACE"
fi


sh -c "pwd;cf $*"
