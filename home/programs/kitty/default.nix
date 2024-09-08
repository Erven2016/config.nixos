{ lib, config, ... }:
let
  inherit (lib) mkOption types mkIf;
in
{
  options = {
    home.programs.kitty = {
      enable = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Installing kitty.";
      };

      startWithZellij = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Start kitty with zellij session.";
      };
    };
  };

  config = {
    programs.kitty.enable = config.home.programs.kitty.enable;

    programs.kitty.settings = {
      font_family = "JetBrainsMono NF";
      font_size = "13.0";
      disable_ligatures = "never";
      "wayland_titlebar_color" = "#000000";
      background_opacity = "0.8";
      "startup_session" = if config.home.programs.kitty.startWithZellij then "zellij.session" else "";
    };

    xdg.configFile."kitty/zellij.session" = mkIf config.home.programs.kitty.startWithZellij {
      text = ''
        launch bash -c "zellij attach kitty || zellij -s kitty"
      '';
    };

  };
}
