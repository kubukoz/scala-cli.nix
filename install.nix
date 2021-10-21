{ pkgs ? import <nixpkgs> {} }:
let
  scala-cli = import (
    # Make sure the rev/sha match your desired version
    pkgs.fetchFromGitHub {
      owner = "kubukoz";
      repo = "scala-cli.nix";
      rev = "v0.0.7-1";
      sha256 = "d2d433f38d7e97f4d4603b886648335ac0cd0ab5";
    }
  );
in
{
  home.packages = [ scala-cli ];
}
