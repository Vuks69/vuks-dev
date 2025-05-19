# shell.nix
{ unstable ? import <nixos-unstable> { allowUnfree = true; } }:

unstable.mkShell {
  buildInputs = [
    (unstable.python3.withPackages (ps: [
      ps.sphinx
      ps.sphinx-rtd-theme
    ]))
  ];
}
