#!/bin/bash
# ----------------------------------------------------------------------------------
# @name    : kernel-mainline-checker
# @version : 0.1
# @date    : 04/07/2013 06:56:05
#
# TENTANG
# ----------------------------------------------------------------------------------
# Script untuk mendapatkan list versi kernel mainline ubuntu di halaman
# http://kernel.ubuntu.com/~kernel-ppa/mainline/
#
# KONTAK
# ----------------------------------------------------------------------------------
# Ada bug? saran? sampaikan ke saya.
# Ghozy Arif Fajri / gojigeje
# email    : gojigeje@gmail.com
# web      : goji.web.id
# facebook : facebook.com/gojigeje
# twitter  : @gojigeje
# G+       : gplus.to/gojigeje
#
# LISENSI
# ----------------------------------------------------------------------------------
# Open Source tentunya :)
#  The MIT License (MIT)
#  Copyright (c) 2013 Ghozy Arif Fajri <gojigeje@gmail.com>


setup() {
  VERSI="0.1"
  LISTFILE="$HOME/gojigeje/kernel-mainline-list"
}

getList() {
  echo ""
  echo " Kernel Ubuntu Mainline Checker by @gojigeje"
  echo " Version $VERSI"
  echo ""
  echo -n " Updating kernel list.."
  if eval "ping -c 1 kernel.ubuntu.com -w 10 > /dev/null"; then
    date +"%d %b" > $LISTFILE
    curl -s http://kernel.ubuntu.com/~kernel-ppa/mainline/ | sed 's/<[^>]\+>/ /g' | sed "s/[ \t]*//$g" | grep "v[0-9]" | cut -d " " -f1 | tr / " " >> $LISTFILE
    echo " [OK]"
  else
    echo " [ERROR]"
    echo " [PING-TIMEOUT] - Gagal menghubungi kernel.ubuntu.com!"
    exit
  fi
}

getListCron() {
  if eval "ping -c 1 kernel.ubuntu.com -w 10 > /dev/null"; then
    date +"%d %b" > $LISTFILE
    curl -s http://kernel.ubuntu.com/~kernel-ppa/mainline/ | sed 's/<[^>]\+>/ /g' | sed "s/[ \t]*//$g" | grep "v[0-9]" | cut -d " " -f1 | tr / " " >> $LISTFILE
  else
    exit
  fi
}

getLastCheck() {
  LASTCHECK=$(head -n 1 $LISTFILE)
}

getLastStable() {
  STABLE1=$(grep -v 'rc[0-9]' $LISTFILE | tail -n 1 | cut -d " " -f1)
}

get2ndStable() {
  STABLE2=$(grep -v 'rc[0-9]' $LISTFILE | tail -n 2 | head -n 1 | cut -d " " -f1)
}

getLastRc() {
  LASTRC=$(grep 'rc[0-9]' $LISTFILE | tail -n 1 | cut -d " " -f1)
}

current() {
  getLastCheck
  getLastStable
  get2ndStable
  getLastRc
  echo " Last Check : $LASTCHECK"
  echo ""
  echo -e " Stable : $STABLE1 \t\tRC : $LASTRC"
  echo "          $STABLE2"
  echo ""
}

conky() {
  getLastCheck
  getLastStable
  get2ndStable
  getLastRc
  echo "(Stable) $STABLE1, $STABLE2 - (RC) $LASTRC ~ $LASTCHECK"
}

usage() {
  echo "Usage :  $0 cek|update|current|conky"
}

setup
case "$1" in
  "cek" )
    getListCron
    ;;

  "update")
    getList
    current
    ;;

  "current")
    echo ""
    echo " Kernel Ubuntu Mainline Checker by @gojigeje"
    echo " Version $VERSI"
    echo ""
    current
    ;;

  "conky")
    conky
    ;;

  *)
    usage
    ;;
esac