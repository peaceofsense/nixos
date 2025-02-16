{ config, pkgs, ... }:

{
  # Enable KDE Connect
  programs.kdeconnect.enable = true;

  # Enable Hyprland with XWayland support
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;

  # Enable adb (Android Debug Bridge)
  programs.adb.enable = true; 

  # Install programs
  programs.firefox.enable = true;
  
  # thunar
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  programs.xfconf.enable = true; # Thunar remembers the setting


  # Enable Neovim and set it as the default editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpacked
  ];
  
  programs.virt-manager.enable = true;
  
  # Enable Steam 
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  #   dedicatedServer.openFirewall = true;
  # };
}
