{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkMerge;
in
{
  config = {
    networking.hostName = "pi";
    # 设置时区
    time.timeZone = "Asia/Taipei";

    # 软件列表
    environment.systemPackages = mkMerge [
      (with pkgs; [
        amdgpu_top
        libheif
        rustup
        gcc
      ])

      (with pkgs.dynamic-gnome-wallpapers; [
        macos-sonoma
        macos-ventura
        macos-sequoia
        moon-far-view
        win11-bloom-ventura
        win11-bloom-gradient
      ])
    ];

    custom-system.desktop.enable = true;

    system.fonts.extraFonts = with pkgs; [
      wqy_microhei
      wqy_zenhei
      source-han-sans
      source-han-serif
      roboto

      nur-erven2016.otf-pingfang
      nur-erven2016.otf-sf-pro
    ];
    system.fonts.extraNerdFonts = [ "JetBrainsMono" ];
    fonts.fontconfig.defaultFonts = {
      sansSerif = [ "PingFang SC" ];
      serif = [ "PingFang SC" ];
    };

    networking.networkmanager.enable = true;

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

    programs.appimage = {
      enable = true;
      binfmt = true;
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

    system.flatpak.enable = true;

  };
}
