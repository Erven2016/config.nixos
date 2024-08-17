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

  options = {
    os.desktop.enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = ''
        enable desktop environment.
      '';
    };

    os.desktop.name = mkOption {
      type = types.str;
      default = "gnome";
      example = "kde";
      description = ''
        The desktop environment what you want to use.
        Avaliable DEs:
          - gnome
      '';
    };

    os.desktop.enableWayland = mkOption {
      type = types.bool;
      default = true;
      example = false;
      description = ''
        enable wayland protocol support for compositor and display manager.
      '';
    };

    os.kernel.enableLatest = mkOption {
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
      # editors
      nano

      # resource monitors
      btop
      htop
      iftop
      iotop

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
    boot.kernelPackages = mkIf (config.os.kernel.enableLatest) pkgs.linuxPackages_latest;
  };
}
