#!/usr/bin/env bash

set -e

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

current=""
current_dir="${script_dir}/systems/current"

if [ -e "${current_dir}" ]; then
  current="$(basename $(readlink ${current_dir}))"
  echo "Current system config is [${current}]"
  echo ""
fi

target="${current}"

if [ ! -z "${1}" ]; then
  if [[ "${1:0:1}" == "_" ]] || [ ! -d "${script_dir}/systems/${1}" ]; then
    echo "${1} is not a valid system type"
    exit 1
  fi
  target="${1}"
fi

if [ "${target}" != "${current}" ] && [ ! -z "${current}" ]; then
  echo "Uninstalling old system config [${current}]..."
  echo ""
  pushd "${script_dir}/systems/${current}" > /dev/null
  DOT_UNINSTALL=1 "${script_dir}/systems/${current}/link.sh"
  rm "${script_dir}/systems/current"
  popd > /dev/null
  echo ""
fi

if [ -z "${target}" ]; then 
  echo "No system configuration target specified"
  exit 1
fi

if [ "${current}" = "${target}" ]; then
  echo "Updating existing system config [${target}]"
else
  echo "Installing new system config [${target}]"
fi
echo ""

pushd "${script_dir}/systems/${target}" > /dev/null
"${script_dir}/systems/${target}/link.sh"
popd > /dev/null

ln -s "${script_dir}/systems/${target}" "${current_dir}"

echo ""
echo "Done!"
echo ""

