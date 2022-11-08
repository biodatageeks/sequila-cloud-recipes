#!/bin/bash

cat <<'EOF'
   _____      ____        _ __                     ___
  / ___/___  / __ \__  __(_) /   ____ _      _____/ (_)
  \__ \/ _ \/ / / / / / / / /   / __ `/_____/ ___/ / /
 ___/ /  __/ /_/ / /_/ / / /___/ /_/ /_____/ /__/ / /
/____/\___/\___\_\__,_/_/_____/\__,_/      \___/_/_/
EOF
echo "SeQuiLa cloud cli version: ${SEQ_VERSION}"


echo "Starting SeQuiLa cli container..."

echo "Terraform variables:"
echo "=========================="
env | grep -i tf_var
echo "=========================="

source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk use java ${JAVA_VERSION}
source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk use scala ${SCALA_VERSION}
source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk use sbt ${SBT_VERSION}
CMD="$@"
export SEQ_CMD=${CMD:-bash}
eval $SEQ_CMD


