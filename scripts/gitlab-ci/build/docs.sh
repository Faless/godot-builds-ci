#!/bin/bash
#
# This build script is licensed under CC0 1.0 Universal:
# https://creativecommons.org/publicdomain/zero/1.0/

set -euo pipefail

export DIR
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$DIR/../_common.sh"

# Install Python dependencies
pip3 install --user -r requirements.txt

# Build documentation in HTML format
make html SPHINXBUILD="$HOME/.local/bin/sphinx-build"
mv "_build/html/" "godot-docs/"
zip -r9 "$ARTIFACTS_DIR/docs/godot-docs-html-nightly.zip" "godot-docs/"

make_manifest "$ARTIFACTS_DIR/docs/godot-docs-html-nightly.zip"
