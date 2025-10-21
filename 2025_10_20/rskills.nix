/**
  No iteration - Only recursion
  sum list of numbers
 */
let
  sum = x: builtins.trace "assert" (
    if builtins.length x == 0 then 0
    else builtins.head x + sum (builtins.tail x));
in
assert (sum [1 2 3] == 6);
assert (sum [] == 0);
sum