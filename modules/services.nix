{ config, pkgs, ... }:

{

  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = false; # Disable full GNOME
    displayManager.gdm.enable = false;

  };
  
  services.gnome.gnome-keyring.enable = true;
  
  # Disable power-profiles-daemon.
  services.power-profiles-daemon.enable = false;

  # TUI login
  services.greetd = {
  enable = true;
  settings = {
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd ${pkgs.hyprland}/bin/Hyprland";
      user = "peaceofsense";
      };
    };
  };


  # Display Manager Settings.
  services.displayManager = {
    # sessionPackages = [ pkgs.gnome.gnome-session.sessions ];
    sddm.enable = false;
  };
  
  # Extra udev rules for i2c devices.
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
  
  # X11 Keymap configuration.
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  
  # Samba service configuration.
  services.samba = {
    enable = true;
  };
  
  # Samba WS-Discovery Daemon configuration.
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
  
  # Mount, trash and other drive functionalites
  services.gvfs.enable = true;
  
  # Interprocess communation system
  services.dbus.enable = true;

  # Thumbnail support for images
  services.tumbler.enable = true;
  
  # CUPS for printing documents.
  services.printing.enable = true;
  
  # TLP for power management.
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = "60";
      STOP_CHARGE_THRESH_BAT0 = "80";
      START_CHARGE_THRESH_BAT1 = "60";
      STOP_CHARGE_THRESH_BAT1 = "80";
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    };
  };
  
  # Enable xrdp service for remote desktop.
  services.xrdp = {
    enable = true;
    openFirewall = true;
  };
  
  services.fwupd.enable = true;
  
  services.blueman.enable = true;
  
  services.solaar = {
    enable = true; # Enable the service
    package = pkgs.solaar; # The package to use
    window = "hide"; # Show the window on startup (show, *hide*, only [window only])
    batteryIcons = "regular"; # Which battery icons to use (*regular*, symbolic, solaar)
    extraArgs = ""; # Extra arguments to pass to solaar on startup
  };
  
  # OpenSSH daemon (commented out, enable if needed).
  services.openssh.enable = true;
  
  services.syncthing = {
    enable = true;
    user = "peaceofsense";
    openDefaultPorts = true;
    dataDir = "/home/peaceofsense/Documents";
    configDir = "/home/peaceofsense/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "android" = { id = "ZQ6VMEA-MAK25XR-JU6NIRF-D45J2SZ-G477RYW-F4Y7YYM-N5UKLVG-TRTFRAN"; };
      };
      folders = {
        "vault" = {
          path = "/home/peaceofsense/Documents/vault";
          devices = [ "android" ];
          type = "sendonly";
          rescanIntervals = 900;
          ignorePerms = false;
        };
      };
    };
  };
  
  services.tailscale.enable = true;
  
  services.flatpak.enable = true;
  
}
