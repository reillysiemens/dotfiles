###############################################################################
#                              __  _  _
#     ____ _ __   _ __  ___   / _|(_)| |  ___
#    |_  /| '_ \ | '__|/ _ \ | |_ | || | / _ \
#  _  / / | |_) || |  | (_) ||  _|| || ||  __/
# (_)/___|| .__/ |_|   \___/ |_|  |_||_| \___|
#         |_|
#
###############################################################################

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

