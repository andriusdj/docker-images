#!/usr/bin/env bash

DIR=$(dirname "${0}");

for IMG in "${DIR}"/*; do
  if [[ -d $IMG ]]; then
    echo ">> Processing ${IMG} ... ";
    (cd "${IMG}" && ./update.sh && echo "<< Done ${IMG}") || echo "<< ERROR! ${IMG} update has failed!"
  fi;
done

echo -e "All Done.\n"
