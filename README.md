# scala-cli.nix

A Nix derivation for scala-cli.

## Versioning

The tags in this repository will correspond to: `v<version of scala-cli>-<release>`, where `release` will be a monotonically increasing number. For example, the first tag is `v0.0.7-0`.

## System support

So far, only Mac is supported, with completions for zsh and bash. Contributions for Linux support welcome.

## Installation

### Easy (latest version)

```shell
nix-env -iA niv -f https://github.com/kubukoz/scala-cli/tarball/main
```

### For NixOS/Home Manager users

`default.nix` is a callPackage-compatible expression. Fetch the file using your prefered method and suit yourself:

<!-- `$ cat install.nix` as nix -->
```nix
{ pkgs ? import <nixpkgs> {} }:
let
  scala-cli = import (
      # Make sure the rev/sha match your desired version
    pkgs.fetchFromGitHub {
      owner = "kubukoz";
      repo = "scala-cli.nix";
      rev = "79d4acec5c227c3f10d590b72456fc4f03eee4fa";
      sha256 = "021c4igdic1cdppmxx65ndb4f10nzlqjzcnqfr1xzb96n6z5fv9s";
    }
  );
in
{
  home.packages = [ scala-cli ];
}
```

### Recommended

1. Use [`niv`](https://github.com/nmattia/niv) and follow its setup instructions
2. `niv add github kubukoz/scala-cli.nix --name scala-cli`
3. Use `sources.scala-cli` wherever you want
