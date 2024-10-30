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
    desktopManager.gnome.enable = true; # Disable full GNOME
    displayManager.gdm.enable = true;
  };

  services.power-profiles-daemon.enable = false;


  services.displayManager = { 
    #  sessionPackages = [ pkgs.gnome.gnome-session.sessions ];
  #  sddm.enable = true;
  };
  # VirtualBox kernel modules load
  virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  #  boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };
  
  services.samba = {
    enable = true;
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
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
    extraGroups = [ "sambashare" "networkmanager" "wheel" "input" "libvirtd" "vboxusers" "qemu-libvirtd" "video" "audio" "disk" ];
    packages = with pkgs; [
    arc-theme
    arc-kde-theme
    graphite-gtk-theme
    graphite-kde-theme
    orchis-theme
    yaru-theme
    ];
  };

  # Install programs
  programs.firefox.enable = true;
  #programs.gh.enable = true;
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

  environment.systemPackages = with pkgs; [
    (lutris.override {
       extraPkgs = pkgs: [
         # List package dependencies here
       ];
    })
    testdisk-qt
    bibata-cursors
    blueman
    btop
    brave
    brightnessctl
    cifs-utils
    cmatrix
    conda
    cowsay
    dconf
    discord
    eyedropper
    fastfetch
    feh
    freerdp3
    fswebcam
    fzf
    gcc
    geany
    git
    gparted
    gnome.gnome-boxes
    gnome.gnome-control-center
    gnome.nautilus
    gnugrep
    grim
    gvfs
    gnome.gvfs
    hfsprogs
    htop
    hypridle
    hyprland
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    jabref
    kitty
    kittysay
    libreoffice-still
    lua
    luajitPackages.luarocks
    neovim
    nix
    nwg-look
    obs-studio
    obsidian
    okular
    openconnect
    # openssl_3_3
    pamixer
    papirus-icon-theme
    pdfarranger
    phinger-cursors
    playerctl
    python3
    qalculate-gtk
    rdesktop
    remmina
    ripgrep
    ripgrep-all
    rofi-wayland
    samba
    slack
    sl
    slurp
    solaar
    stow
    steam-run
    spotify
    starship
    stow
    #sublime4
    swayidle
    swaylock-effects
    telegram-desktop
    texliveFull
    texstudio
    thunderbird
    trash-cli
    tree
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
    wsdd
    xclip
    xdg-utils
    xournalpp
    yazi
    zathura
    zoom-us
    zotero
    zoxide
    # Install a package from unstable
  ];

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
      #xdg-desktop-portal-gtk
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
  nixpkgs = {
    overlays = [
      (self: super: {
        gnome = super.gnome.overrideScope (selfg: superg: {
          gnome-shell = superg.gnome-shell.overrideAttrs (old: {
            patches = (old.patches or []) ++ [
              (let
                # bg = pkgs.fetchurl {
                #   url = "https://orig00.deviantart.net/0054/f/2015/129/b/9/reflection_by_yuumei-d8sqdu2.jpg";
                #   sha256 = "0f0vlmdj5wcsn20qg79ir5cmpmz5pysypw6a711dbaz2r9x1c79l";
                # };
              in pkgs.writeText "bg.patch" ''
                --- a/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                +++ b/data/theme/gnome-shell-sass/widgets/_login-lock.scss
                @@ -15,4 +15,5 @@ $_gdm_dialog_width: 23em;
                 /* Login Dialog */
                 .login-dialog {
                   background-color: $_gdm_bg;
                +  background-color: #000000;
                 }
              '')
            ];
          });
        });
      })
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.xrdp = {
    enable = true;
    openFirewall = true;
  };


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3389 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

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
