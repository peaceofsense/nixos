{ config, pkgs, ... }:

{

# Enable the GNOME Desktop Environment.
services.xserver = {
  enable = true;
  desktopManager.gnome.enable = true; # Disable full GNOME
  displayManager.gdm.enable = true;
};

# Disable power-profiles-daemon.
services.power-profiles-daemon.enable = false;

# Display Manager Settings.
services.displayManager = {
  # sessionPackages = [ pkgs.gnome.gnome-session.sessions ];
  # sddm.enable = true;
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

# OpenSSH daemon (commented out, enable if needed).
# services.openssh.enable = true;

}
