{
  imports = [
    ./devshell.nix # a dev shell that provieds all that you will need to work
    ./formatter.nix # formatter for nix fmt
    ./treefmt.nix # treefmt is another formatter for every lanauage
    ./pre-commit.nix # pre-commit hooks to help manage the flake
  ];
}
