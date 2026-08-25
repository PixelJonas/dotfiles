# jEnv — lazy-loaded to avoid its ~600ms startup penalty.
# Calling jenv/java/javac triggers the real init on first use.
if command -v jenv &>/dev/null; then
  _jenv_load() {
    unfunction jenv java javac 2>/dev/null
    eval "$(command jenv init -)"
  }
  jenv()  { _jenv_load && jenv "$@"; }
  java()  { _jenv_load && java "$@"; }
  javac() { _jenv_load && javac "$@"; }
fi
