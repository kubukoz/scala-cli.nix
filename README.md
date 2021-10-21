# scala-cli.nix

A Nix derivation for scala-cli.

## Versioning

The tags in this repository will correspond to: `v<version of scala-cli>-<release>`, where `release` will be a monotonically increasing number. For example, the latest tag is:

<!-- `$ git tag --sort=authordate | tail -n 1` -->
```
v0.0.7-2
```

## System support

So far, Mac (x86) and Linux (x86) are supported, with completions for zsh and bash.

## Installation

For all methods, you can set up `cachix use kubukoz` to benefit from a binary cache (mac only)

### Easy (latest version)

```shell
nix-env -if https://github.com/kubukoz/scala-cli.nix/archive/refs/heads/main.tar.gz
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
      rev = "v0.0.7-1";
      sha256 = "d2d433f38d7e97f4d4603b886648335ac0cd0ab5";
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
