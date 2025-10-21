

let
  /**
    For each system
   */
  forEachSystem = acc: systems: f:
  if builtins.length systems == 0 then acc
  else
  let
    acc' = acc // (f (builtins.head systems));

    # This is currying - One input and one output
    forEachSystem' = forEachSystem acc';
  in
    forEachSystem' (builtins.tail systems) f; 
in
forEachSystem {}