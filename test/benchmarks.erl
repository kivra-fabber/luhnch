-module(benchmarks).

-export([
    run/0
]).

run() ->
    test(<<"0">>, 10000, microsecond),
    test(<<"4711">>, 10000, microsecond),
    test(<<"121212121">>, 10000, microsecond),
    test(<<"123456789012345678901234567890">>, 10000, microsecond),
    test(<<"123456789101112131415161718192021222324252627282930313233343536373839404142434445464748495051525354555657585960616263646566676869707172737475767778798081828384858687888990919293949596979899100">>, 10000, microsecond),
    ok.

test(Digits, Duration, Unit) ->

    %% The Rust NIF
    RustOp = fun () -> luhn:sum(Digits) end,
    %% A simple Erlang implementation
    ErlOp = fun () -> s2_hash:luhn(Digits) end,

    io:format("Duration: ~B ~p\n", [Duration, Unit]),
    io:format("    Data: ~p\n", [Digits]),

    RustIters = iterate(Duration, Unit, RustOp, 100),
    ErlIters = iterate(Duration, Unit, ErlOp, 100),

    io:format("    Rust: ~10.. B iterations\n", [RustIters]),
    io:format("  Erlang: ~10.. B iterations\n", [ErlIters]),
    io:format("   Ratio: ~10.2. f (Rust/Erlang)\n", [RustIters / ErlIters]),
    io:format("\n"),

    ok.

iterate(Duration, Unit, Op, Resolution) ->
    iterate(Duration, Unit, Op, 0, erlang:monotonic_time(Unit), Resolution).
iterate(Duration, Unit, Op, Iterations, T0, Resolution) ->
    Op(),
    T1 = case Iterations rem Resolution of
        0 -> erlang:monotonic_time(Unit);
        _ -> T0 %% cheating, but hey
    end,
    TimeLeft = Duration - (T1 - T0),
    if
        TimeLeft < 0 -> Iterations;
        true -> iterate(Duration, Unit, Op, Iterations + 1, T0, Resolution)
    end.
