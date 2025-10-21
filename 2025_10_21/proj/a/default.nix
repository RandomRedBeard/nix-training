{
  stdenv,
  breakpointHook,
  help2man,
  ...
}:
stdenv.mkDerivation {
  name = "hello";
  src = builtins.fetchTarball {
    url = "http://gnu.mirror.constant.com/hello/hello-2.9.tar.gz";
    name = "hello";
  };
  # src = ./hello-2.9;
  doCheck = true;

  # runHook is added if someone else is using the pre / post  hooks
  # Not needed for this example, but buildGoModule or other language builders may use it
  configurePhase = ''
    runHook preConfigure;
    ./configure --prefix $out;
    runHook postConfigure;
  '';
  buildPhase = ''
    runHook preBuild;
    make;
    runHook postBuikd;
  '';
  checkPhase = ''
    runHook preCheck;
    make check;
    runHook postCheck;
  '';

  # Throws error, triggers breakpoint for attach
  installPhase = ''
    runHook preInstall;
    make install;
    runHook postInstall;
  '';
  nativeBuildInputs = [
    breakpointHook
    help2man
  ];
}