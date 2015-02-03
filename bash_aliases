alias df='df -h'
alias du='du -h -c'

psgrep() {
  ps aux | grep -v grep | egrep "$1|PID"
}

# vim: filetype=sh:expandtab:shiftwidth=2:softtabstop=2
