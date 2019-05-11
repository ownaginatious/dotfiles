#!/bin/bash

set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

current=""

if [ -f "${HOME}/.dot-system" ]; then
  current="$(cat ${HOME}/.dot-system)"
else
  echo "No system configuration installed"
  exit 1
fi

echo "Uninstalling system configuration [${current}]"

pushd "${script_dir}/systems/${current}" > /dev/null
DOT_UNINSTALL=1 "${script_dir}/systems/${current}/link.sh"
popd > /dev/null

rm -f "${HOME}/.dot-system"