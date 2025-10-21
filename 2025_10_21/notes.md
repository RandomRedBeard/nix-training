nix-store --query --tree $(nix-build)
 vs 
nix-store --query --tree $(nix-instantiate)


whats required to run
whats required to build + run

[thomas@nixos:~/sources/nix-training/2025_10_20/excercise]$ nix why-depends --derivation $(nix-instantiate) nixpkgs#glibc


Copy closure to server
nox copy --to ssh://server $(nix-build ...)


-- PINNING --
Specifying a version of some software to prevent upstream breaking changes
Flakes already do this, but it is imperfect

Not guarunteed that our nixpkgs match (across machines)

```
pkgs_src = builtins.fetchTarball with nixpkgs to guaruntee nixpkgs version
pkgs = import ./pkgs_src {}
```

Down side of pinning, there is a chance that something can go missing. CDN can go down, Cache can be gc-ed.


-- NPINS --
another mechanism just for pinning 

```
[nix-shell:~/sources/nix-training/2025_10_21]$ npins add github nixos nixpkgs -b nixos-unstable --name nixpkgs
[nix-shell:~/sources/nix-training/2025_10_21]$ npins add github nixos nixpkgs -b nixos-21.11 --name nixpkgs-old

nix-repl> import ./npins
{
  nixpkgs = { ... };
  nixpkgs-old = { ... };
}

nix-repl> o = import ./npins
nix-repl> import o.nixpkgs {}

nix-repl> import o.nixpkgs-old {}
```

-- FLAKES --
Might not work in anduril **
nix flake init 

pin via flake input
nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
nixpkgs-old.url = "github:nixos/nixpkgs?ref=nixos-21.11";


-- STDENV --

mkDerivation usually does 
```
fetch
untar
cd
./configure
make
make test
make install
```

naticeBuildInputs = compile time deps
buildInputs = run time deps
propagatedBuildInputs = run time deps of scripts
checkInputs = test deps

Just appending things to the path, no real magic

mkDerivation uses phases
unpackPhase
patchPhase
configurePhase
buildPhase
checkPhase
installPhase
fixuupPhase
installCHeckPhase
distPhase


hash - fetchX with an empty hash, then put hash
nix hash file <file> - did not work for thomas

[nix-shell:~/sources/nix-training/2025_10_21]$ nix-shell -p nix-prefetch-scripts
[nix-shell:~/sources/nix-training/2025_10_21]$ nix-prefetch-git git@github.com:RandomRedBeard/libcosmic.git


pkgs.breakpointHook
if a phase fails, you can attach to the sandbox and "poke around"

Check trivial builders

mkShell - Try not to fill up shellHooks
inputsFrom pulls nativeBuildInputs and buildInputs (NOTE checkInputs)