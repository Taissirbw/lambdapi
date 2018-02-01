#!/bin/bash

LAMBDAPI="../../lambdapi.native"
SRC="https://deducteam.github.io/data/libraries/verine.tar.gz"
DIR="verine"

# Cleaning command (clean and exit).
if [[ "$#" -eq 1 && "$1" = "clean" ]]; then
  rm -rf ${DIR}
  rm -f verine.tar.gz
  exit 0
fi

# Rejecting other command line arguments.
if [[ "$#" -ne 0 ]]; then
    echo "Invalid argument, usage: $0 [clean]"
    exit -1
fi

# Prepare the library if necessary.
if [[ ! -d ${DIR} ]]; then
  # The directory is not ready, so we need to work.
  echo "Preparing the library:"

  # Download the library if necessary.
  if [[ ! -f verine.tar.gz ]]; then
    echo -n "  - downloading...      "
    wget -q ${SRC}
    echo "OK"
  fi

  # Extracting the source files.
  echo -n "  - extracting...       "
  tar xf verine.tar.gz
  echo "OK"

  # Applying the changes (add "#REQUIRE logic").
  echo -n "  - applying changes... "
  for FILE in `ls ${DIR}/SEQ*.dk`; do
    sed -i "s/^#NAME/#REQUIRE logic.\n#NAME/g" ${FILE}
  done
  echo "OK"

  # Cleaning up.
  echo -n "  - cleaning up...      "
  rm verine.tar.gz
  rm ${DIR}/Makefile
  echo "OK"

  # All done.
  echo "Ready."
  echo ""
fi

# Checking function.
function check_verine() {
  rm -f logic.dko
  ${LAMBDAPI} --gen-obj logic.dk
  for FILE in `ls SEQ*.dk`; do
    ${LAMBDAPI} ${FILE}
  done
}

# Export stuff for the checking function.
export readonly LAMBDAPI=${LAMBDAPI}
export -f check_verine

# Run the actual checks.
cd ${DIR}
\time -f "Finished in %E at %P with %MKb of RAM" bash -c "check_verine"
