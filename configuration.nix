# Use your harware-configuration.nix


{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/fonts.nix
      ./modules/packages.nix
      ./modules/pipewire.nix
      ./modules/programs.nix
      ./modules/service.nix
    ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.devices = [ "nodev" ] ;
  boot.loader.grub.efiSupport = true;	

  networking.hostName = "nixos"; # Define your hostname.
  systemd.services.NetworkManager-wait-online.enable = false;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8"];
  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  # Enable i2c
  hardware.i2c.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";


  # Kernel modules load
  # boot.extraModulePackages = [ config.boot.kernelModules.ddcci-driver ];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-amd" "kvm-intel" "v4l2loopback"]; # "i2c-dev" "ddcci_backlight"];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Webcam"
  '';

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.peaceofsense = {
    isNormalUser = true;
    description = "peaceofsense";
    extraGroups = [ "adbsuers" "sambashare" "networkmanager" "i2c" "wheel" "input" "libvirtd" "vboxusers" "qemu-libvirtd" "video" "audio" "disk" ];
    packages = with pkgs; [
    arc-theme
    arc-kde-theme
    graphite-gtk-theme
    graphite-kde-theme
    orchis-theme
    yaru-theme
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fileSystems."/mnt/share" = {
    device = "//131.188.251.29";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      #xdg-desktop-portal-gtk
      #xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  }; 
  # Enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";  # Runs garbage collection weekly
  nix.gc.options = "--delete-older-than 30d";
  


  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3389 ];
  # networking.firewall.allowedUDPPorts = pkgs.lib.range 1714 1764; # Full KDE Connect range
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
}
