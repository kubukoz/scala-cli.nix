{ stdenv, coreutils, lib, installShellFiles, system, zlib, autoPatchelfHook, makeSetupHook }:
let
  version = "0.0.7";
in
stdenv.mkDerivation {
  name = "scala-cli";
  inherit version;
  buildInputs = let
    # Implemented as a custom setup hook because autopatchelf needs to run first.
    # if you know how to do this without a custom setup hook, please let me know.
    completionsHook = makeSetupHook { name = "completions-hook"; deps = [ installShellFiles ]; } ./completions-hook.sh;
  in
    [
      coreutils
      autoPatchelfHook
      completionsHook
    ];
  src =
    let
      asset = {
        x86_64-darwin = {
          asset = "scala-cli-x86_64-apple-darwin.gz";
          sha256 = "0v6vlmw1zrzvbpa59y4cfv74mx56lyx109vk9cb942pyiv0ia6gf";
        };
        x86_64-linux = {
          asset = "scala-cli-x86_64-pc-linux.gz";
          sha256 = "1xdkvjfw550lpjw5fsrv7mbnx5i8ix8lrxcd31yipm8p9g4vjcdn";
        };
      }."${system}";
    in
      builtins.fetchurl {
        url = "https://github.com/Virtuslab/scala-cli/releases/download/v${version}/${asset.asset}";
        sha256 = asset.sha256;
      };
  unpackPhase = ''
    cat $src | gzip -d > scala-cli
  '';

  nativeBuildInputs = [
    zlib
    stdenv.cc.cc
  ];

  installPhase =
    ''
      #
        mkdir -p "$out/bin"
        chmod 755 scala-cli
        cp scala-cli "$out/bin/"
    '';

}
