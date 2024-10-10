{ pkgs, config, ... }:
{
  imports = [ ];

  environment.systemPackages =
    with pkgs;
    [
      flatpak-builder # flatpak dev

      amdgpu_top

      libheif

      rustup
      gcc
    ]
    ++ (with dynamic-gnome-wallpapers; [
      macos-sonoma
      macos-ventura
      macos-sequoia
      moon-far-view
      win11-bloom-ventura
      win11-bloom-gradient
    ]);

  os.bootloader.enable = true;

  custom-system.desktop.enable = true;

  custom-system = {
    fonts = {
      extra-fonts = with pkgs; [
        wqy_microhei
        wqy_zenhei
        source-han-sans
        source-han-serif
        roboto

        nur-erven2016.otf-pingfang
        nur-erven2016.otf-sf-pro

        (nerdfonts.override {
          fonts = [
            "FiraCode"
            "JetBrainsMono"
            "IBMPlexMono"
          ];
        })
      ];
    };
  };

  custom-modules.enable-google-chrome-wayland = true;

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
  networking.hostName = "EliteBook845G11";

  # Set your time zone.
  time.timeZone = "Asia/Taipei";

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
        # rime # disable it because librime-lua is under unstable now.
      ];
    };
  };

  hardware.opengl = {
    ## radv: an open-source Vulkan driver from freedesktop
    driSupport = true;
    driSupport32Bit = true;

    ## amdvlk: an open-source Vulkan driver from AMD
    extraPackages = [ pkgs.amdvlk ];
    extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

  # hardware.steam-hardware.enable = true;

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
          #libsForQt5.breeze-qt5  # for Plasma
          gnome.gnome-themes-extra # for Gnome
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
}
