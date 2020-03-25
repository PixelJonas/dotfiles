# sup yarn
# https://yarnpkg.com

if test -n "$(command -v yarn)" && test -n "$(command -v node)"
then
  export PATH="$PATH:`yarn global bin`"
fi
