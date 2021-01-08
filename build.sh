#!/bin/sh
echo 'Starting Deploy'
git pull
PACKAGE_JSON_DIFF=`git diff HEAD@{0} HEAD@{1} | grep "package.json"`
if [ "$PACKAGE_JSON_DIFF" != "" ]; then
    echo 'Find change of package.json, starting download packages'
    npm install
fi

echo 'Starting clean project'
npm run clean

echo 'Starting build project'
npm run build

echo 'Deploy success'