{ pkgs ? import <nixpkgs> {} }:
let
  scala-cli = import (
    pkgs.fetchFromGitHub {
      owner = "kubukoz";
      repo = "scala-cli.nix";
      # Make sure the rev/sha match your desired version
      rev = "79d4acec5c227c3f10d590b72456fc4f03eee4fa";
      sha256 = "021c4igdic1cdppmxx65ndb4f10nzlqjzcnqfr1xzb96n6z5fv9s";
    }
  );
in
{
  home.packages = [ scala-cli ];
}
