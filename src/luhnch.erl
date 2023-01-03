%%% Copyright 2023, Fabian Bergström <fabian.bergstrom@kivra.com>.
%%%
%%% Licensed under the Apache License, Version 2.0 (the "License");
%%% you may not use this file except in compliance with the License.
%%% You may obtain a copy of the License at
%%%
%%%     http://www.apache.org/licenses/LICENSE-2.0
%%%
%%% Unless required by applicable law or agreed to in writing, software
%%% distributed under the License is distributed on an "AS IS" BASIS,
%%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%% See the License for the specific language governing permissions and
%%% limitations under the License.

-module(luhnch).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

check_test() ->
    true = luhn:check(<<"1212121212">>),
    false = luhn:check(<<"1212121213">>),
    true = luhn:check(<<"0">>),
    false = luhn:check(<<"1">>),
    ok.

sum_test() ->
    2 = luhn:sum(<<"121212121">>),
    8 = luhn:sum(<<"4711">>),
    3 = luhn:sum(<<"7992739871">>),
    ok.

bork_test() ->
    -1 = luhn:sum(<<"bork bork bork">>),
    false = luhn:check(<<"">>),
    ok.

-endif.
