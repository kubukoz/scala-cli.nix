{ pkgs ? let
    sources = import ./nix/sources.nix;
  in
    import sources.nixpkgs {}
}:
pkgs.callPackage ./derivation.nix {}
