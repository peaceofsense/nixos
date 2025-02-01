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
  programs.thunar.enable = true;

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
  # Enable Steam 
  # programs.steam = {
  #   enable = true;
  #   remotePlay.openFirewall = true;
  #   dedicatedServer.openFirewall = true;
  # };
}
