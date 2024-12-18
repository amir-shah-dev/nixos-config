{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./zsh.nix
#    ./nushell.nix
  ];
}
