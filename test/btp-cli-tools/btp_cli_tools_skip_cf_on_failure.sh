#!/bin/bash
set -e
source dev-container-features-test-lib

check "failed CF package is not installed" bash -c "! dpkg-query -W cfdoes-not-exist-cli >/dev/null 2>&1"
check "failing CF repository is removed" bash -c "test ! -e /etc/apt/sources.list.d/cloudfoundry-cli.list"
check "requested plugins are skipped" bash -c "test ! -e \"$CF_PLUGIN_HOME/SOURCE-NOTICE\""
check "APT remains usable" sudo apt-get update

reportResults