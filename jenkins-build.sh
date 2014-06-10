#!/bin/bash -ex

cabal update
(cd patching/ && ./scripts/create-tarballs.sh)
cabal install
cabal install Cabal-$(cabal --version | sed -n 's@using version \(.*\) of the Cabal library@\1@p')
./dist/build/stackage/stackage select --no-platform
./dist/build/stackage/stackage check
./dist/build/stackage/stackage build
./dist/build/stackage/stackage test
./create-stackage-tarball.sh
