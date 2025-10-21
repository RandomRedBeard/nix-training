/**
  Take n elements from list
 */

let
  takeN = n: x:
  if n == 0 || builtins.length x == 0 then []
  else
    [(builtins.head x)] ++ (takeN (n - 1) (builtins.tail x));
in
takeN