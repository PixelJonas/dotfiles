# GRC colorizes nifty unix tools all over the place
if test "$(command -v grc)" && test "$(command -v brew)"; then
  source $(brew --prefix)/etc/grc.bashrc
fi
