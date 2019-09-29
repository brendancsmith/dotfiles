#!/bin/sh

sh $(dirname $0)/bindrop.sh

# rustup / cargo
curl -sSf https://sh.rustup.rs | sh && source $HOME/.cargo/env

## parsyncfp
# curl -sSf https://raw.githubusercontent.com/hjmangalam/parsyncfp/0f69f996a0522588e115ba97c6d28b94b8fddfad/parsyncfp > /usr/local/bin/parsyncfp
#chmod +x /usr/local/bin/parsyncfp


# disable System Integrity Protection (SIP) for selected frameworks
# (such as Dtrace to enable running iotop, iosnoop, etc.)
# 1. Enter terminal in Recovery Mode
# 2.
#       csrutil disable
# 3.
#       csrutil enable ––without dtrace
