{ stdenv, coreutils, lib, installShellFiles, jre, system, autoPatchelfHook, zlib }:
let
  version = "0.0.7";
in
stdenv.mkDerivation {
  name = "scala-cli";
  inherit version;
  buildInputs = [ coreutils installShellFiles ];
  src =
    let
      asset = {
        x86_64-darwin = {
          asset = "scala-cli-x86_64-apple-darwin.gz";
          sha256 = "0v6vlmw1zrzvbpa59y4cfv74mx56lyx109vk9cb942pyiv0ia6gf";
        };
        # doesn't work so far
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

  propagatedBuildInputs = [ jre ];

  installPhase =
    let
      # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation
      libPath = lib.makeLibraryPath [
        stdenv.cc.cc.lib
        zlib
      ];
      fixBinary =
        if builtins.currentSystem == "x86_64-linux" then
          ''
            patchelf \
              --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
              --set-rpath "${libPath}" \
              $out/bin/scala-cli
          '' else "";
    in
      ''
        mkdir -p "$out/bin"
        chmod 755 scala-cli
        cp scala-cli "$out/bin/"
        ${fixBinary}

        # hack to ensure the completion function looks right
        PATH="$out/bin:$PATH"

        for shell in zsh bash; do
          scala-cli completions "$shell" > "completions_$shell"
          installShellCompletion --name _scala-cli "--$shell" "completions_$shell"
          echo "installed completions for $shell"
        done
      '';

}
