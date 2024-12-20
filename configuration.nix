# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, helix, neovim, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Casablanca";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.supportedLocales = ["all"];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Enable KDE Plasma
  services.xserver.enable = true;
  # services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  # services.xserver.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  # services.xserver = {
  #  layout = "gb,ara";
  #  xkbVariant = "";
  #  xkbOptions = "grp:win_space_toggle";
  # };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amir = {
    isNormalUser = true;
    description = "amir";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    packages = with pkgs; [
      firefox
    #  thunderbird
    ];
  };
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

#  programs.hyprland.enable = true; # enable Hyprland

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and the new command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     # micro
     nb
     zoom-us
     pass
     screen
     acpi
     git
     wget
     curl
     libgcc
     gcc13
    xclip
    unrar
    kitty

     helix.packages."${pkgs.system}".helix
     neovim.defaultPackage.x86_64-linux
  ];
  environment.variables.EDITOR = "nvim";
#  environment.interactiveShellInit = ''
#  alias ls='lsd'
#'';



  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
        jetbrains-mono
        noto-fonts
    ];

    fontconfig = {
        defaultFonts = {
            serif = ["jetbrains-mono" "noto-sans"];
            sansSerif = ["jetbrains-mono" "noto-sans"];
            monospace = ["jetbrains-mono"];
        };
    };
  };

  networking.extraHosts =
    ''
      127.0.0.1 nixos
      #<no-surf>
      # 127.0.0.1	reddit.com
      # 127.0.0.1	www.reddit.com
      127.0.0.1	facebook.com
      127.0.0.1	www.facebook.com
      127.0.0.1	twitter.com
      127.0.0.1	www.twitter.com
      127.0.0.1	netflix.com
      127.0.0.1	www.netflix.com
      127.0.0.1	twitch.tv
      127.0.0.1	www.twitch.tv
      127.0.0.1	youtube.com
      127.0.0.1	www.youtube.com
      #</no-surf>
    '';

	# powerManagement.powerDownCommands = ''
		# sudo echo enabled > /sys/bus/usb/devices/usb1/power/wakeup
		# sudo echo enabled > /sys/bus/usb/devices/usb2/power/wakeup
		# sudo echo enabled > /sys/bus/usb/devices/usb3/power/wakeup
		# sudo echo enabled > /sys/bus/usb/devices/usb4/power/wakeup
    # '';
	# powerManagement.powerUpCommands = ''
		# sudo echo enabled > /sys/bus/usb/devices/usb1/power/wakeup
		# sudo echo enabled > /sys/bus/usb/devices/usb2/power/wakeup
		# sudo echo enabled > /sys/bus/usb/devices/usb3/power/wakeup
		# sudo echo enabled > /sys/bus/usb/devices/usb4/power/wakeup
    # '';


    # systemd.services.protonmail-bridge = {
      # enable = true;
      # description = "Service to run the Protonmail bridge client";
      # wantedBy = [ "default.target" ];
      # serviceConfig = {
      	# Type = "simple";
        # ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive";
        # StandardOutput = "journal";
      # };
    # };


 #    systemd.services."drive-sync" = {
	# script = ''
	# 	set -eu
	# 	${pkgs.rclone}/bin/rclone sync /home/amir/Documents/drive pd-remote:drive --fast-list
	# '';
	# serviceConfig = {
	# 	Type = "oneshot";
	# 	User = "amir";
	# };
 #    };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
