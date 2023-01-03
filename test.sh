#! /bin/bash

set -euo pipefail

pushd rust/luhn
cargo test
popd

rebar3 eunit