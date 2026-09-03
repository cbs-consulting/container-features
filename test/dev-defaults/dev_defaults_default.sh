#!/bin/bash
# Scenario test for 'dev-defaults'.
# The feature has no install-time binaries — it only delivers VS Code
# customizations. This smoke test verifies the install script runs cleanly.
set -e

source dev-container-features-test-lib

check "feature install completes" echo "ok"

reportResults
