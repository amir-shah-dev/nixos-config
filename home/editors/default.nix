{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./micro.nix
    ./spacemacs.nix
#    ./neovim.nix
  ];
}
