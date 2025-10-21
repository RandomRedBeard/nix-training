2025.10.20 - First Day
1. Nix trainer late - Picked up at gate
2. Trainer lives in thailand
3. Bump nix version to >=2.18.4
4. Intros 
  a. Skill sets
  b. about us (stack, nix opinions, expectations)

5. Trainer flexing on class by wc -l nixpkgs contrib

6. nix is a pyramid scheme
7. Goals of nix
  a. How to write patches
  b. Cross compilation
  c. Nix remote builders
  d. No grades, no prizes, help each other

8. George Bush jr joke (no child left behind)

-- Bathroom Break --

9. Nix == Dutch
10. Nix trying to reduce software complexity (version hell)
11. Cache sending 2.27 pb last month (2024)
  a. Not all things in cache still exist (stale git commits that have been removed)

12. No big corp backing
13. Nix vs determinate nix installer
  a. Mutli-user nix vs single user nix
  b. Communist vibes (your machine or OUR machine)



14. nix commands
  a. nix profile
  b. nix shell vs nix develop V nix-shell
  c. nix-collect-garbage
  d. nix repl --file '<nixpkgs>'
    Load nixpkgs variables into repl
  e. nix build V nix-build
  f. nix-instantiate (create drv from nix expr)
  g. nix derivation show
  h. nix-store -r
    nix-store --realise --add-root result

    Hold onto the build and shell without rebuilding

-- NIX PROFILE --

 - nixos configuration > nix profile
   assumes nixos
   doing the same thing under the hood

15. nix profile install nixpkgs#hello
  a. Install hello into nix profile
  b. install is deprecated for add
  c. nix profile remote <pkg name>

16. Flakes are good from the user side (bad from the developer side)
  a. Just install x

17. Nix is a pile of symlinks

18. nix-env -p /nix/var/nix/profiles/system --delete-generates +15
19. nix profile upgrade --all && nix profile --list

20. nix-collect-garbage -d 


-- NIX REPL --

nix repl --file '<nixpkgs>'
:doc lib.zipLists

| zipListsWith :: (a -> b -> c) -> [a] -> [b] -> [c]

universally typed inputs (any type) (for all)
given a list of a and list of b return list c

-> function output

(a -> b -> c) is a function [first arg]
[a] is a list a [second arg]
[b] is a list b [third arg]
[c] is a return list c [return value]


Why no commas in lists - It could be worse, semi colons as list sep

-- ATTR SET --
like python dict
inhert is a spread like operator (inherit x == x = x;)
inhert (s) a b a = s.a; b = s.b (like unpacking)

-- LOGICAL OPERATORS --

standard 

set = {a=1;}
set ? a # set has a

Composition
nix-repl> :doc builtins.hasAttr  
Synopsis: builtins.hasAttr s set
    hasAttr returns true if set has an attribute named s, and false otherwise. This is a dynamic version of the ? operator, since s is an expression rather than an identifier.


Value or default
set.c or 10 # 10
set.a or 10 # 1

-- CURRYING --
person - Haskell Curry

function takes on arguemnt and returns one thing

plusOne = x: x + 1
Takes an arg and returns a function

(x: x + 1) 10 
11

nix-repl> f = a: b: a + b

nix-repl> f 1 2
3

prime - too lazy to make another function
nix-repl> plusOne' = f 1

nix-repl> pls
pls
nix-repl> plusOne' 10
11


Everything is a function
Paranthesis are used for grouping not for calling

How do you pass multiple things?
Attr set

python kwargs
nix-repl> f = {a, b}: a + b
nix-repl> f {a=1;b=2;}
3


@ pun operator
name outer scope

nix-repl> h = s@{a, ...}: a + s.b
nix-repl> h{a=1; b=2;}
3

allows scope peeling 


-- LET BLOCK --
Last things is implicit return value
nix-repl> let x = 1; y = 2; in x + y
3



-- WITH --
pulls things into scope
with s; [a b]

inherits a and b from scope

let scope and with

nix-repl> let s={ a = 1; b = 2; c = 3;}; in with s; [a b] 
[
  1
  2
]

nix-repl> let s={ a = 1; b = 2; c = 3;}; in with s; [a b c]
[
  1
  2
  3
]


nix-repl> s1 = {a=1;}

nix-repl> s2 = {a=2;}

nix-repl> with s1; with s2; a 
2

nix-repl> let a = 3; with s1; with s2; a
error: syntax error, unexpected WITH, expecting IN_KW or INHERIT
       at «string»:1:12:
            1| let a = 3; with s1; with s2; a
             |            ^

nix-repl> let a = 3; in with s1; with s2; a
3


Closest scope takes precedence 
let block takes over with

need to convert integers to strings to interopelate

nix-repl> bla = "blah"                 

nix-repl> ''
          inter ${bla}
          not inter: ''${blah}
          
          '
          '
          ''
"inter blah\nnot inter: \${blah}\n\n'\n'\n"


nix-repl> ''
          ''${blah} asd ${builtins.toString x}
          ''
"\${blah} asd 1\n"

nix-repl> ''${blah} asd ''${builtins.toString x}
          

nix-repl> ''                                     
          ''${blah} asd ''${builtins.toString x}
          ''
"\${blah} asd \${builtins.toString x}\n"

magic strings

-- ATTR UPDATE -- 
nix-repl> { x = 1; z = 2;} // {y=2; z = 3;}
{
  x = 1;
  y = 2;
  z = 3;
}

STD LIB r update
nix-repl> :p pkgs.lib.recursiveUpdate {x={y=2;};} {x={z=3;};}
{
  x = {
    y = 2;
    z = 3;
  };
}

Always return new thing, never mutate the state
anarchists

-- IMPORT --
Read nix file, import returns value (w/e value is in nix file)

x.nix''
1 + 1
''
import x # 2

-- Logging --

Lazy evaluation means you have to call a function for trace to work

nix-repl> x = 1
nix-repl> builtins.trace "value of x: ${builtins.toString x}" (x + 1)
trace: value of x: 1
2

not guarunteed for operations to occur when expected (addition and multiplcation are communicative so they can happen whenever)

-- MATH --

let
y = [(1/0) (2/0)];
in
if builtings.length y > 1
    then "all good"
    else x

Elements in y are never evaluated


-- BUILTINS --
head and tail (under builtins)

head is the first
tail is the rest

head on empty list == error

check length of list first

-- FIB --
fib.nix 
```
let
  fib = x:
    if x == 0 then 0
    else if x == 1 then 1
    else fib (x - 1) + fib (x - 2);
in
  fib
```

-- NIXPKGS --
when importing nixpkgs, you can configure it
allow unfree, broken, insecure w/e

License generation from nix


-- PACKAGE --
Derivation is a machine readale recipe for building a package
translated via nix-instantiate
then realised

Its a graph
(n inputs) -> drv -> output

hash both inputs and output so the drv is reproducable 

``

[thomas@nixos:~/sources/nix-training/2025_10_20]$ nix-instantiate drv.nix 
warning: you did not specify '--add-root'; the result might be removed by the garbage collector
/nix/store/p5m3600bnhpj70vj445yf41gyyrcasia-mydrv.drv

[thomas@nixos:~/sources/nix-training/2025_10_20]$ ls -la /nix/store/p5m3600bnhpj70vj445yf41gyyrcasia-mydrv.drv
-r--r--r-- 1 root root 569 Dec 31  1969 /nix/store/p5m3600bnhpj70vj445yf41gyyrcasia-mydrv.drv

[thomas@nixos:~/sources/nix-training/2025_10_20]$ nix-store -r /nix/store/p5m3600bnhpj70vj445yf41gyyrcasia-mydrv.drv
warning: you did not specify '--add-root'; the result might be removed by the garbage collector
/nix/store/mwad0da3vbd3zm8qxbw1idk7whk96jk8-mydrv

[thomas@nixos:~/sources/nix-training/2025_10_20]$ ls /nix/store/mwad0da3vbd3zm8qxbw1idk7whk96jk8-mydrv
/nix/store/mwad0da3vbd3zm8qxbw1idk7whk96jk8-mydrv

[thomas@nixos:~/sources/nix-training/2025_10_20]$ cat /nix/store/mwad0da3vbd3zm8qxbw1idk7whk96jk8-mydrv
foobar
``

./builder.sh without quotes is special. Tells nix to copy the file/dir to the nix store