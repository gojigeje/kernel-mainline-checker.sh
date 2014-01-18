kernel-mainline-checker.sh
==========================

(very) Simple bash script to check and display ubuntu newest stable and RC mainline kernel from http://kernel.ubuntu.com/~kernel-ppa/mainline/‎

####USAGE

```bash
$ ./kernel-mainline-checker.sh 

  Usage:       ./kernel-mainline-checker.sh <action>

  Action:      cek | quiet    Run script in quiet mode (write to cache, no output)
               update         Run script in verbose mode (display process and output)
               current        Display current (cached) kernel version
               conky          Display current (cached) kernel version one line output
                              (conky friendly)

$ ./kernel-mainline-checker.sh update

 Ubuntu Kernel Mainline Checker by @gojigeje
 Version 0.1

 Updating kernel list.. [OK]
 Last Check : 18 Jan

 Stable : v3.12.8-trusty      RC : v3.13-rc8-trusty
          v3.12.7-trusty

```
