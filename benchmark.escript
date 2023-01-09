#!/usr/bin/env escript
%%! -pa _build/default/lib/luhnch/ebin/ _build/test/lib/luhnch/test/

main(_Args) ->
    case ready_to_go() of
        true -> benchmarks:run();
        false -> ok
    end.

ready_to_go() ->
    try
        {module, luhn} = code:ensure_loaded(luhn),
        {module, stdlib2} = code:ensure_loaded(stdlib2),
        {module, benchmarks} = code:ensure_loaded(benchmarks),
        true
    catch
        _:Error ->
            io:format("~p -- did you forget to compile first?\n", [Error]),
            false
    end.
