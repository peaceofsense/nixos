{ pkgs, ... }: {

  # List packages installed in system profile.

  environment.systemPackages = with pkgs; [
    # Office and Productivity
    anki
    jabref
    libreoffice-still
    obsidian
    kdePackages.okular
    #    opentabletdriver
    megasync
    pandoc
    pdfarranger
    texliveFull
    texstudio
    thunderbird
    xournalpp
    zathura
    zotero

    # Disk and Filesystem Utilities
    cifs-utils
    exfatprogs
    gparted
    hfsprogs
    ntfs3g
    testdisk-qt


    # System Utilities
    blueman    
    brightnessctl
    btop
    dconf
    ddcutil
    ddcui
    feh
    fzf
    nautilus
    gnugrep
    grim
    gvfs
    gnome.gvfs
    htop
    hypridle
    hyprland
    hyprlock
    hyprpaper
    hyprpicker
    hyprshot
    kitty
    kittysay
    libnotify
    neovim
    pamixer
    parted
    qalculate-gtk
    ripgrep
    ripgrep-all
    rofi-wayland
    samba
    sl
    slurp
    smartmontools
    sticky
    stow
    swaynotificationcenter
    swayidle
    swaylock-effects
    tealdeer
    trash-cli
    tree
    unzip
    wget
    wl-clipboard
    xclip
    xdg-utils
    zip
    zoxide

    # System Customization
    bibata-cursors
    eyedropper
    fastfetch
    gnome-control-center
    gnomeExtensions.gsconnect
    nwg-look
    papirus-icon-theme
    phinger-cursors
    starship
    waybar
    wl-color-picker

    # Web Browsing
    brave
    vivaldi
    vivaldi-ffmpeg-codecs

    # Development Tools
    conda
    gcc
    geany
    git
    lua
    luajitPackages.luarocks
    python3
    vscode
    wtype

    # Networking and Communication
    discord
    ferdium
    fractal
    freerdp3
    github-desktop
    kdePackages.kdeconnect-kde
    openconnect
    rdesktop
    remmina
    solaar
    telegram-desktop
    wsdd
    kdePackages.xwaylandvideobridge #x11 to wayland screensharing
    zoom-us

    # Hardware and Peripherals
    droidcam

    # Multimedia
    ffmpeg-full
    fswebcam
    libheif
    libraw
    nufraw
    obs-studio
    playerctl
    pavucontrol
    scrcpy
    spotify
    vlc

    # Virtualisation
    gnome-boxes
    virtualbox

    # Miscellaneous
    android-tools
    cmatrix
    cowsay
    wttrbar
    yazi
    dotnet-runtime
  ];

}
