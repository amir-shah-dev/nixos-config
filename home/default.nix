{ config, pkgs, ... }:

{

  imports = [
    ./programs
    ./shell
    ./editors
  ];

#  programs.kitty.enable = true; # required for the default Hyprland config
#  wayland.windowManager.hyprland.enable = true; # enable Hyprland

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "amir";
    homeDirectory = "/home/amir";

        packages = with pkgs; [
                obsidian
                rclone
                jetbrains.pycharm-professional
                jetbrains.webstorm
                python3
        poetry
#        nodePackages.pyright
        vscode-langservers-extracted
        vscode
        black
        thonny
        anki
        xournalpp
        protonmail-desktop
        standardnotes
        telegram-desktop
        libreoffice
        ihp-new
        direnv
        stack
        ghc
        rnote
        pdfarranger
        ruby
        megasync
        ];
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
 

