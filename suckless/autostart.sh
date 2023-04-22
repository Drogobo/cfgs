#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

run xinput set-prop "Logitech G502 HERO SE" "libinput Accel Profile Enabled" 0 0
run xinput set-prop "Logitech G502 HERO SE" "libinput Accel Speed" 0
