-module(stdlib2).

-export([
    luhn/1
]).

luhn(String) when is_binary(String) ->
    luhn(binary_to_list(String));
luhn(String) when is_list(String) ->
    IntList  = lists:map(fun(ASCII) -> ASCII - 48 end, String),
    {_, Sum} = lists:foldr(fun luhn_fold/2, {odd, 0}, IntList),
    (Sum*9) rem 10.

luhn_fold(X, {odd, Sum}) ->
    Y = X * 2,
    N = case Y > 9 of
          true  -> Y - 9;
          false -> Y
        end,
    {even, Sum + N};
  luhn_fold(X, {even, Sum}) ->
    {odd, Sum + X}.
