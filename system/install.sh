#!/bin/sh

sh $(dirname $0)/bindrop.sh

curl https://sh.rustup.rs -sSf | sh && source $HOME/.cargo/env
