#!/bin/bash
# Scenario test for 'typescript' (typescript only, ts-node skipped).
set -e

source dev-container-features-test-lib

check "tsc is installed" tsc --version
check "ts-node is not installed" bash -c "! command -v ts-node"

reportResults
