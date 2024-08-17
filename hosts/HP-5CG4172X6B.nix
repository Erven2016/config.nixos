{ pkgs, config, ... }:
{
  imports = [ ];

  os.bootloader.enable = true;
  os.desktop.enable = true;

  # todo: modulize above

  # Remove sound.enable or set it to false if you had it set previously, as sound.enable is only meant for ALSA-based configurations

  # rtkit is optional but recommended
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  networking.networkmanager.enable = true;
  networking.hostName = "HP-5CG4172X6B";

  # Set your time zone.
  time.timeZone = "Asia/Taipei";

  users.users = {
    erven2016 = {
      isNormalUser = true;
      extraGroups = [
        "docker"
        "wheel"
        "networkmanager"
      ];
      # packages = with pkgs; [ rustup v2raya ];
    };
  };

  # ZSH & oh-my-zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    # history.size = 10000;
    # history.path = "${config.xdg.dataHome}/zsh/history";

    # Use oh-my-zsh as zsh plugin manager
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "gentoo";
    };
  };

  # Set zsh as default shellI
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # ProxyChains
  programs.proxychains = {
    enable = true;
    proxies.prx1 = {
      enable = true;
      type = "socks5";
      host = "127.0.0.1";
      port = 7890;
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        libpinyin
        rime
      ];
    };
  };

  # Flatpak
  services.flatpak = {
    enable = true;
  };

  # To fix CJK fonts can not display normally
  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [
          "ro"
          "resolve-symlinks"
          "x-gvfs-hide"
        ];
      };
      aggregatedIcons = pkgs.buildEnv {
        name = "system-icons";
        paths = with pkgs; [
          #libsForQt5.breeze-qt5  # for plasma
          gnome.gnome-themes-extra
        ];
        pathsToLink = [ "/share/icons" ];
      };
      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
      };
    in
    {
      "/usr/share/icons" = mkRoSymBind "${aggregatedIcons}/share/icons";
      "/usr/local/share/fonts" = mkRoSymBind "${aggregatedFonts}/share/fonts";
    };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    packages = with pkgs; [
      corefonts # Microsoft's TrueType core fonts for the Web
      noto-fonts
      noto-fonts-cjk
      noto-fonts-extra
      noto-fonts-emoji
      wqy_microhei
      wqy_zenhei
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      source-han-sans
      source-han-serif
      sarasa-gothic # 更纱黑体
      source-code-pro
      hack-font
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DroidSansMono"
          "JetBrainsMono"
        ];
      })
      roboto
      nur-erven2016.otf-pingfang
      nur-erven2016.otf-sf-pro
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "Noto Sans Mono CJK SC"
          "Noto Color Emoji"
          "Sarasa Mono SC"
          "DejaVu Sans Mono"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "Noto Color Emoji"
          "Source Han Sans SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "Noto Color Emoji"
          "Source Han Serif SC"
          "DejaVu Serif"
        ];
      };
    };
  };
}
