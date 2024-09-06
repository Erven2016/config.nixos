{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkOption types;
in
{
  imports = [ ] ++ import ./module-list.nix;

  options.custom-system = {
    desktop.enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = ''
        enable desktop environment.
      '';
    };

    desktop.name = mkOption {
      type = types.str;
      default = "gnome";
      example = "kde";
      description = ''
        The desktop environment what you want to use.
        Avaliable DEs:
          - gnome
      '';
    };

    desktop.enableWayland = mkOption {
      type = types.bool;
      default = true;
      example = false;
      description = ''
        enable wayland protocol support for compositor and display manager.
      '';
    };

    kernel.enableLatest = mkOption {
      type = types.bool;
      default = true;
      example = false;
      description = ''
        use latest linux kernel
      '';
    };
  };

  config = {
    # minimal system enviroment setup
    environment.systemPackages = with pkgs; [
      joshuto

      pkg-config

      # editors
      nano

      # resource monitors
      btop
      htop
      iftop
      iotop
      bottom

      # hardware info & check
      powertop
      lm_sensors
      ethtool
      pciutils
      usbutils
      fastfetch

      # file compressing tools
      unzip
      zip
      gnutar

      # http request tools
      wget
      curl

      # other tools
      git
      less

      # NixOS
      nixos-icons
    ];

    # use latest linux kernel
    boot.kernelPackages = mkIf (config.custom-system.kernel.enableLatest) pkgs.linuxPackages_latest;

    boot.extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';

    # Z SHELL (ZSH)
    # users.defaultUserShell = pkgs.zsh;
    # environment.shells = with pkgs; [ zsh ];
    programs.zsh.enable = true;

  };
}
