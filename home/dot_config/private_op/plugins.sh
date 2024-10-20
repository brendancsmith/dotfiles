#!/usr/bin/env sh

if [ -z "$OP_PLUGIN_ALIASES_SOURCED" ]; then
	export OP_PLUGIN_ALIASES_SOURCED=1
	alias gh="op plugin run -- gh"
	alias openai="op plugin run -- openai"
	alias aws="op plugin run -- aws"
fi
