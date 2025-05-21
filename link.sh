#!/usr/bin/env bash

function error {
  printf "\033[0;31m${1}\033[0m\n"
}

function realpath {
  [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

function link {
  source="$(realpath "${1}")"
  target="$(realpath "${2}")"

  if [ -z "${DOT_UNINSTALL}" ]; then
    echo "Creating link [${source}] -> [${target}]"
  else
    echo "Removing link [${source}] -> [${target}]"
  fi

  if [ ! -f "${source}" ] && [ ! -d "${source}" ] ; then
    error " -> !! Source does not exist [${source}] !! "
    return 1
  fi

  if [ -f "${target}" ] || [ -d "${target}" ]; then
    if [ ! -L "${target}" ]; then
      error " -> !! ${target} exists but is not a symlink! !!"
      return 1
    elif [ ! "${source}" -ef "$(readlink ${target})" ]; then
      error " -> !! ${target} is a symlink, but does not point to the source !!"
      error "    [${source}] != [$(readlink ${target})]"
      return 1
    fi
  fi

  if [ ! -z "${DOT_UNINSTALL}" ]; then
    rm "${target}"
    echo " -> Symlink removed"
  else
    if [ -e "${target}" ]; then
      echo " -> Already exists"
    else
      mkdir -p "$(dirname ${target})"
      ln -s "${source}" "${target}"
      echo " -> Symlink created"
    fi
  fi
}
