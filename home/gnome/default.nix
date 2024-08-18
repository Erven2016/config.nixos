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
    dconf = mkIf (config.home.desktop.gnome.extension.enable) {
      enable = mkForce true;
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enable-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          # dash-to-panel.extensionUuid
          dash-to-dock.extensionUuid
          customize-ibus.extensionUuid
          appindicator.extensionUuid
          auto-activities.extensionUuid
          gnome-40-ui-improvements.extensionUuid
        ];
      };
    };

    home.packages = mkIf config.home.desktop.gnome.extension.enable (
      with pkgs.gnomeExtensions;
      [
        blur-my-shell
        # dash-to-panel
        dash-to-dock
        customize-ibus
        appindicator
        auto-activities
        gnome-40-ui-improvements
      ]
    );
  };
}
