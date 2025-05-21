#!/usr/bin/env bash

set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

current_dir="${script_dir}/systems/current"

if [ ! -e "${current_dir}" ]; then
  echo "No system configuration installed"
  exit 1
fi

echo "Uninstalling system configuration [${current}]"

pushd "${current_dir}" > /dev/null
DOT_UNINSTALL=1 "${current_dir}/link.sh"
popd > /dev/null

rm -f "${current_dir}"

