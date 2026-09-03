#!/bin/bash
set -e
source dev-container-features-test-lib

check "fallbackscope registry mapping written" bash -c "npm config get '@fallbackscope:registry' | grep -i pkgs.fallback.com"
check "post-create script exists and is executable" test -x /usr/local/share/npm-feeds/post-create.sh
check "fallback auth token written" bash -c "grep -q '_authToken=pat-fallback' ~/.npmrc"
check "user npm config is private" bash -c "test \"\$(stat -c '%a' ~/.npmrc)\" = 600"

reportResults
