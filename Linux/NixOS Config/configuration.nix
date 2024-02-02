# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;
#  boot.loader.efi.efiSysMountPoint = "/boot/efi";
#  boot.loader.systemd-boot.configurationLimit = 3;

  # GRUB 2

  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      splashMode = "normal";
      backgroundColor = "#000000";
      splashImage = null;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

  };

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # /etc/hosts file:
  networking.extraHosts =
  ''

  '';

  # networking.extraHosts = "127.0.0.1 derroidos.com\n127.0.0.1 www.marca.com";


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
    videoDrivers = [ "nvidia" ];
    # Enable the KDE Plasma Desktop Environment.
    desktopManager.plasma5.enable = true;
    displayManager = {
      sddm.enable = true;
      setupCommands = "xrandr --output DVI-D-0 --off\n";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.salva = {
    isNormalUser = true;
    description = "Salva";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "openrazer" ];
    packages = with pkgs; [
    #  firefox
    #  kate
    #  vlc
    #  wget
    #  sublime4
    #  screenfetch
    #  plex
    #  thunderbird
    ];
  };
  

  # Servicios
  services = {
    plex.enable = true;
    flatpak.enable = true;
  };


#  xdg.portal.enable = true;
#  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    polychromatic
    openrazer-daemon
    xorg.xdpyinfo
    wayland
    plex-media-player
    firefox
    kate
    vlc
    wget
    sublime4
    screenfetch
    libsForQt5.konqueror
  ];

  # Razer

  hardware.openrazer.enable = true;
  users.groups.plugdev.gid = 1001;
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # programs.plasma.discover.enable = true;

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
  system.stateVersion = "22.11"; # Did you read the comment?

}
