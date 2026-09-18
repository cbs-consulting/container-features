#!/bin/bash
set -e
source dev-container-features-test-lib

if cf version >/dev/null 2>&1; then
	check "cf is installed" cf version
	check "cf is on PATH" bash -c "command -v cf"
else
	check "failing CF repository is removed" bash -c "test ! -e /etc/apt/sources.list.d/cloudfoundry-cli.list"
	check "APT remains usable" sudo apt-get update
fi

reportResults
