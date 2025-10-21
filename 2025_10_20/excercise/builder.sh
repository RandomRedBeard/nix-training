# mkdir -p $out/bin
# make -C $src/mini-hello -o $out/bin/mini-hello

cp $src/* .

mkdir -p $out/bin
make -C $src
mv mini-hello $out/bin