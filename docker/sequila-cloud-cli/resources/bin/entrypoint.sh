#!/bin/bash

cat <<'EOF'
   _____      ____        _ __                     ___
  / ___/___  / __ \__  __(_) /   ____ _      _____/ (_)
  \__ \/ _ \/ / / / / / / / /   / __ `/_____/ ___/ / /
 ___/ /  __/ /_/ / /_/ / / /___/ /_/ /_____/ /__/ / /
/____/\___/\___\_\__,_/_/_____/\__,_/      \___/_/_/
EOF
echo "SeQuiLa cloud cli version: ${SEQ_VERSION}"


# check required env variables before proceeding
: "${TF_VAR_project_name:?ERROR: Env variable TF_VAR_project_name not set !!!}"
: "${TF_VAR_region:?ERROR: Env variable TF_VAR_location not set !!!}"
: "${TF_VAR_zone:?ERROR: Env variable TF_VAR_zone not set !!!}"
export GOOGLE_PROJECT=${TF_VAR_project_name}

echo "Starting SeQuiLa cli container..."
echo "=========================="
echo "GOOGLE_PROJECT: ${GOOGLE_PROJECT}"
echo "Location: ${TF_VAR_region}"
echo "Zone: ${TF_VAR_zone}"
echo "=========================="

source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk use java ${JAVA_VERSION}
source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk use scala ${SCALA_VERSION}
source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk use sbt ${SBT_VERSION}
CMD="$@"
export SEQ_CMD=${CMD:-bash}
eval $SEQ_CMD


