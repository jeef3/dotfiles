#!/usr/bin/env bash
set -euo pipefail

test_dir="$(cd "$(dirname "$0")" && pwd)"

"$test_dir/test-nvim.sh"
"$test_dir/test-spinner.sh"
"$test_dir/test-bootstrap.sh"
"$test_dir/test-setup.sh"
