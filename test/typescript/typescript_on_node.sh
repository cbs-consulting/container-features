#!/bin/bash
# Scenario test for 'typescript' (typescript + ts-node).
set -e

source dev-container-features-test-lib

check "tsc is installed" tsc --version
check "ts-node is installed" ts-node --version

reportResults
