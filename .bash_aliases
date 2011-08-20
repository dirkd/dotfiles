alias df='df -h'
alias du='du -h -c'

if [ -x /usr/bin/lsb_release ]; then
  if [[ "$(lsb_release -i)" == *Arch ]]; then
    alias remdeps='pacman -Rs $(pacman -Qtdq)'
    alias dist-upgrade='pacman -Syu'
  fi
fi

#alias rm='rm -v'
alias wine='padsp wine'
alias playhd='mplayer -ao alsa -vo vdpau -vc ffh264vdpau,ffvc1vdpau,ffmpeg12vdpau -demuxer lavf -cache 8192'

psgrep() {
	ps aux | grep -v grep | egrep "$1|PID"
}

extract() {
  local c e i

  (($#)) || return

  for i; do
    c=''
    e=1

    if [[ ! -r $i ]]; then
      echo "$0: file is unreadable: \`$i'" >&2
      continue
    fi

    case $i in
      *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
        c='bsdtar xvf';;
      *.7z)  c='7z x';;
      *.Z)   c='uncompress';;
      *.bz2) c='bunzip2';;
      *.exe) c='cabextract';;
      *.gz)  c='gunzip';;
      *.rar) c='unrar x';;
      *.xz)  c='unxz';;
      *.zip) c='unzip';;
      *)
        echo "$0: unrecognized file extension: \`$i'" >&2
        continue;;
    esac

    command $c "$i"
    e=$?
  done

  return $e
}

# vim: filetype=sh:expandtab:shiftwidth=2:softtabstop=2
