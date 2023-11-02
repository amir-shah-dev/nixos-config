{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./micro.nix
    ./neovim.nix
  ];
}
