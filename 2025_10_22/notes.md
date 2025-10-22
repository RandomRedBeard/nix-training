

IFD (import from derivation) - bad

src should not be ./. - this brings everything into the nix store
filesets ? maybe subdirs

lib.cleanSource ./.; drops some files


-- FILESETS --
lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.union [
        ./include
        ./test
    ];
};

fs.gitTracked

ÄthomasÉnixos:ü/sources/redbeard-nix-configÅ$ nix-store --export $(nix-store --query --requisites /nix/store/ws0ypqn2igsskflzmvlxmvvw1njs2sdr-hello-armv7l-unknown-linux-gnueabihf-2.12.1) > closure.nar
thomas@beagle:~$ cat closure.nar | nix-store --import


-- PATCHING / SUBSTITUTION --
/usr/bin/env | shebang

-- OVERLAYS --

provide overrides to everyone without specifying the override per package
add packages


