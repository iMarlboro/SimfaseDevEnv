#!/usr/bin/env bash
# from Homestead


cp src/stubs/Vagrantfile "Vagrantfile"
cp -i src/stubs/SimfaseDevEnv.yaml "SimfaseDevEnv.yaml"
cp -i src/stubs/after.sh "after.sh"
cp -i src/stubs/aliases "aliases"

echo "SimfaseDevEnv initialized!"