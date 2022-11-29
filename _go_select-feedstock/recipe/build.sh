#!/usr/bin/env bash
set -eufx

#
# Install and source the [de]activate scripts.
for F in deactivate activate; do
  F_DIR="${PREFIX}/etc/conda/${F}.d"
  mkdir -p "${F_DIR}"
  cp -v "${RECIPE_DIR}/${F}-go.sh" "${F_DIR}/${F}_z60-go.sh"
done

source "${F_DIR}/activate_z60-go.sh"
