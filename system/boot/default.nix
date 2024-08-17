{
  lib,
  config,
  # pkgs,
  inputs,
  system,
  ...
}:
let
  inherit (lib)
    mkIf
    mkDefault
    mkOption
    types
    ;
in
{
  options = {
    os.bootloader.enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = ''
        enable bootloader.
      '';
    };
  };
  config = mkIf config.os.bootloader.enable {
    boot.loader = {
      efi = {
        canTouchEfiVariables = mkDefault true;
        efiSysMountPoint = mkDefault "/boot"; # ← use the same mount point here.
      };
      grub = {
        enable = mkDefault true;
        efiSupport = mkDefault true;
        #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
        device = mkDefault "nodev";
        theme = mkDefault inputs.distro-grub-themes.packages.${system}.nixos-grub-theme;
      };
    };
  };
}
