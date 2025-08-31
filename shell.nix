# shell.nix
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz") { } }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.python3.withPackages (ps: [
      ps.sphinx
      ps.sphinx-rtd-theme
    ]))
  ];
}
