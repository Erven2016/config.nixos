{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkOption
    mkIf
    mkForce
    types
    ;
in
{

  imports = [ ];
  options = {
    # system::gnome implements in Home-manager section
    home.desktop.gnome.extension = {
      enable = mkOption {
        type = types.bool;
        default = true;
        example = false;
        description = "Enable extension support for gnome.";
      };
    };
  };

  config = {
    # gnome extension management by Home-manager
    dconf =
      mkIf (config.home.desktop.gnome.extension.enable)
        {
          enable = mkForce true;
          settings."org/gnome/shell" = {
            disable-user-extensions = false;
            enable-extensions = with pkgs.gnomeExtensions; [
              blur-my-shell.extensionUuid
              window-is-ready-remover.extensionUuid
              dash-to-panel.extensionUuid
              customize-ibus.extensionUuid
              appindicator.extensionUuid
            ];
          };
        };

    home.packages =
      mkIf config.home.desktop.gnome.extension.enable (
        with pkgs.gnomeExtensions;
        [
          blur-my-shell
          window-is-ready-remover
          dash-to-panel
          customize-ibus
          appindicator
        ]
      )
      ;
  };
}
