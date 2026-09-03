#!/bin/bash
set -e
source dev-container-features-test-lib

check "scope1 registry mapping written" bash -c "npm config get '@scope1:registry' | grep -i pkgs.example.com"
check "scope2 registry mapping written" bash -c "npm config get '@scope2:registry' | grep -i npm2.example.com"
check "post-create script exists and is executable" test -x /usr/local/share/npm-feeds/post-create.sh
check "feeds.conf written with 3 columns" bash -c "awk -F'\t' 'NF==3' /usr/local/share/npm-feeds/feeds.conf | wc -l | grep -q 2"
check "scope1 auth token written" bash -c "grep -q '_authToken=pat-for-scope1' ~/.npmrc"
check "scope2 auth token written" bash -c "grep -q '_authToken=pat-for-scope2' ~/.npmrc"
check "auth token safely updated" bash -c "TEST_TOKEN_2='pat&updated' bash /usr/local/share/npm-feeds/post-create.sh >/dev/null && grep -qxF '//npm2.example.com/registry/:_authToken=pat&updated' ~/.npmrc"
check "updated auth token not duplicated" bash -c "grep -cF '//npm2.example.com/registry/:_authToken=' ~/.npmrc | grep -qx 1"
check "user npm config is private" bash -c "test \"\$(stat -c '%a' ~/.npmrc)\" = 600"

reportResults
