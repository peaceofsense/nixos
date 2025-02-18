{ pkgs, ... }: {

  fonts = {
    packages = with pkgs; [
      # Fonts
      fira-code-nerdfont
      font-awesome
      material-icons
      material-design-icons
      emacs-all-the-icons-fonts
      roboto
      google-fonts
      work-sans
      corefonts
      vistafonts
      comic-neue
      source-sans
      twemoji-color-font
      comfortaa
      inter
      lato
      lexend
      jost
      dejavu_fonts
      nerdfonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      jetbrains-mono
      font-awesome_5
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
    ];

    enableDefaultPackages = false;

    # This fixes emoji stuff
    fontconfig = {
      defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "JetBrainsMono"
          "Noto Color Emoji"
        ];
        sansSerif = ["Lexend" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # Install GTK/Qt Themes and Icon Themes
  environment.systemPackages = with pkgs; [
    # GTK Themes
    arc-theme
    adwaita-qt
    graphite-gtk-theme
    orchis-theme

    # Icon Themes
    papirus-icon-theme
    tela-icon-theme
    breeze-icons
    gnome-themes-extra
  ];

  
}
