#!/bin/bash
set -e

source_path=${1:-.}
file_hash="$(cd "$source_path" && find . -type f -not -name '*.pyc' -not -path './.**' | sort | xargs md5sum)"
hash="$(echo "$file_hash" | md5sum | cut -d' ' -f1)"
echo '{ "hash": "'"$hash"'" }'
