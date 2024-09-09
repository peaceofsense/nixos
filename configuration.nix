# Use your harware-configuration.nix

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./fonts.nix
      ./pipewire.nix
    ];

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.devices = [ "nodev" ] ;
  boot.loader.grub.efiSupport = true;	

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

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

  # Enable Hyprland
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = false; # Disable full GNOME
    displayManager.gdm.enable = true;    # Enable GDM (GNOME Display Manager) if you want to keep the login manager
  };

  services.displayManager.sessionPackages = [ pkgs.gnome.gnome-session.sessions ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

# Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.peaceofsense = {
    isNormalUser = true;
    description = "peaceofsense";
    extraGroups = [ "networkmanager" "wheel" "input" "libvirtd" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install programs
  programs.firefox.enable = true;
  programs.thunar.enable = true;
  programs.neovim = {
  	enable = true;
	defaultEditor = true;
  };
  programs.steam = {
  	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    blueman
    btop
    brave
    brightnessctl
    cmatrix
    conda
    cowsay
    discord
    eyedropper
    fastfetch
    ffmpeg
    freerdp
    fswebcam
    gcc
    geany
    git
    gparted
    grim
    htop
    hyprland
    hyprpaper
    hyprpicker
    jabref
    kitty
    kittysay
    libreoffice-still
    lua
    luajitPackages.luarocks
    neovim
    nix
    obs-studio
    obsidian
    openconnect
    pamixer
    pdfarranger
    python3
    ripgrep
    ripgrep-all
    rofi-wayland
    slack
    sl
    slurp
    solaar
    stow
    spotify
    stow
    swayidle
    swaylock-effects
    texstudio
    thunderbird
    unzip
    vivaldi
    vivaldi-ffmpeg-codecs
    virtualbox
    vlc
    vscode
    waybar
    wget
    whatsapp-for-linux
    wl-clipboard
    wl-color-picker
    xclip
    xdg-utils
    zoom-us
  ];
  
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  }; 
  # Enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";  # Runs garbage collection weekly
  nix.gc.options = "--delete-older-than 30d";

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
  system.stateVersion = "24.05"; # Did you read the comment?

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Channels to flakes
}
