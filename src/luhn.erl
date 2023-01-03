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

%% must match the name in the nif loader
-module(luhn).

-on_load(init/0).
-export([init/0]).

-export([add/2]).

init() ->
    %% code:priv_dir/1 only works for a proper application, but
    %% luhn is (for now) just library application
    EbinDir = filename:dirname(code:which(?MODULE)),
    ParentPath = filename:dirname(EbinDir),
    Priv = filename:join(ParentPath, "priv"),
    erlang:load_nif(filename:join(Priv, "libluhn"), none).

add(_, _) ->
    exit({not_loaded, [{module, ?MODULE}, {line, ?LINE}]}).
