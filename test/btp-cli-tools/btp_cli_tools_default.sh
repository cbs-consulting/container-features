#!/bin/bash
set -e
source dev-container-features-test-lib

check "cf is installed" cf version
check "cf is on PATH" bash -c "command -v cf"

reportResults
