#!/bin/sh

PACKAGE_JSON_DIFF=`git diff HEAD@{0} HEAD@{1} | grep "package.json"`
if [ "$PACKAGE_JSON_DIFF" != "" ]; then
    npm install
fi

npm run clean
npm run build