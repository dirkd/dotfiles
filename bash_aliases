alias df='df -h'
alias du='du -h -c'

alias wine='padsp wine'
alias playhd='mplayer -ao alsa -vo vdpau -vc ffh264vdpau,ffvc1vdpau,ffmpeg12vdpau -demuxer lavf -cache 8192'

psgrep() {
  ps aux | grep -v grep | egrep "$1|PID"
}

# vim: filetype=sh:expandtab:shiftwidth=2:softtabstop=2
