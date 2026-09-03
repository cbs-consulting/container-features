#!/bin/bash
set -e
source dev-container-features-test-lib

check "cf is installed" cf version
check "cf is on PATH" bash -c "command -v cf"
check "shared plugin home is configured" bash -c "test \"$CF_PLUGIN_HOME\" = /usr/local/share/cf-plugins"
check "multiapps plugin is installed" bash -c "cf plugins | grep -i multiapps"
check "community plugin source notice exists" bash -c "grep -q 'unreviewed third-party binaries' \"$CF_PLUGIN_HOME/SOURCE-NOTICE\""
check "shared plugins are root-owned" bash -c "test -z \"\$(find \"$CF_PLUGIN_HOME\" ! -user root -print -quit)\""
check "shared plugins are not group or world writable" bash -c "test -z \"\$(find \"$CF_PLUGIN_HOME\" -perm /022 -print -quit)\""

reportResults
