/**
  take n numbers from list
  Tail first recursion
 */

let
  takeN = acc: n: x:
  if n == 0 || builtins.length x == 0 then acc
  else 
    let
      # Acc prime, nice for formatting instead of takeN (acc + [])
      acc' = acc ++ [(builtins.head x)];
    in
      takeN acc' (n - 1) (builtins.tail x);
in
takeN []