#!/bin/bash
# Default test for the 'btp-cli-tools' feature, applied on the base image.
set -e

# Optional: Import test library bundled with the devcontainer CLI.
source dev-container-features-test-lib

check "cf is installed" cf version
check "cf is on PATH" bash -c "command -v cf"

# Report results. If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
