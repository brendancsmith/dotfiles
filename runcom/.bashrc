

alias list-commands='compgen -A function -A command -A alias -A enabled'


#TODO: add xman

function viewman() { man -t "$@" | open -f -a "Preview" ;}

alias beep='tput bel'
alias bell='tput bel'

function alert() {
    beep && echo $'\e]9;'"$1"'\007'
}

alias iostat='iostat -w1'

function test-upload() {
    local REMOTE_HOST="$1"
    iperf3 -c $REMOTE_HOST -w 640k -P 5 -t 60
}

function test-download() {
    local REMOTE_HOST="$1"
    iperf3 -c $REMOTE_HOST -w 640k -P 5 -t 60 -R
}
