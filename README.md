luhnch
=====

A "one day" hack looking at how to make Rustler and NIFs work.

Prerequisites
-------------

* [Erlang](https://www.erlang.org/downloads)
* [Rebar 3](http://rebar3.org/docs/getting-started/)
* [Rust](https://rustup.rs)

There are only compiler hooks setup for macOS and Linux, but I'm sure things
would work fine on Windows as well. Edit the `pre_hooks` in
[rebar.config](./rebar.config) to add a "windows" variant.

Build
-----

The Rebar3 config has hooks to build the Rust code, so you just need:

    $ rebar3 compile


Test
----

To run unit tests:

    $ ./test.sh

To run benchmarks:

    $ ./benchmark.escript

Copyright
---------

Apache License Version 2.0, see the LICENSE file.

The module s2_hash is copied straight out from
https://github.com/kivra/stdlib2, also Apache 2.0
