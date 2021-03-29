OS_NAME="linux"

if test "$(uname)" = "Darwin"; then
  OS_NAME="mac"
fi

if test ! $(command -v oc); then
  echo "Installing OpenShift CLI"
  mkdir -p "${DOTFILE_HOME}/openshift-cli/tmp"
  curl -sSL "https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-${OS_NAME}.tar.gz" > "${DOTFILE_HOME}/openshift-cli/tmp/oc.tar.gz"
  
  tar xvzf "${DOTFILE_HOME}/openshift-cli/tmp/oc.tar.gz" --directory "${DOTFILE_HOME}/openshift-cli/tmp" "oc" 
  
  cp "${DOTFILE_HOME}/openshift-cli/tmp/oc" "$HOME/bin/oc"
  
  sudo chmod +x "$HOME/bin/oc"
  rm -rf "${DOTFILE_HOME}/openshift-cli/tmp"
fi
