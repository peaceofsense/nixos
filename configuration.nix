# Use your harware-configuration.nix


{ config, pkgs, pkgsUnstable, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/fonts.nix
      ./modules/packages.nix
      ./modules/pipewire.nix
      ./modules/programs.nix
      ./modules/services.nix
      ./modules/users.nix
    ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.devices = [ "nodev" ] ;
  boot.loader.grub.efiSupport = true;
  # Kernel modules load
  # boot.extraModulePackages = [ config.boot.kernelModules.ddcci-driver ];
  boot.kernelModules = [ "kvm-amd" "kvm-intel" "v4l2loopback"]; # "i2c-dev" "ddcci_backlight"];
  boot.extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Virtual Webcam"
  '';


  # Disable waiting for NetworkManager to be online (speeds up boot)
  systemd.services.NetworkManager-wait-online.enable = false;

  # Wireless (Uncomment if using Wi-Fi with wpa_supplicant)
  # networking.wireless.enable = true;  

  # Hostname Configuration
  networking.hostName = "monolith"; 

  # Network Configuration
  networking.networkmanager.enable = true;
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  # networking.proxy.default = "http://user:password@proxy:port/";  # Uncomment if needed
    
  # Open ports in the firewall.
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 3389 18080 37889 18089 37889];
  # networking.firewall.allowedUDPPorts = pkgs.lib.range 1714 1764; # Full KDE Connect range

  # Hardware Configuration
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;
  
  # Enable I2C
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
  
  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Virtualization
  users.groups.libvirtd.members = ["peaceofsense"];
  virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.docker.enable = true;


  # Configure console keymap
  console.keyMap = "de";

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
      xdg-desktop-portal-gtk
      #xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  }; 
  
  # Enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";  # Runs garbage collection weekly
  nix.gc.options = "--delete-older-than 30d";
  

  # Polkit
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    });
  '';

  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
}
