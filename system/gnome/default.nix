{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkOption mkIf types;
in
{
  imports = [ ];
  options = { };
  config =
    mkIf (config.custom-system.desktop.enable && config.custom-system.desktop.name == "gnome")
      {
        # enable xorg display server
        services.xserver = {
          enable = true;
          displayManager.gdm.enable = true;
          displayManager.gdm.wayland = config.custom-system.desktop.enableWayland;
          desktopManager.gnome.enable = true;
        };

        # flatpak needs
        xdg.portal.enable = true;

        # excludePackages
        environment.gnome.excludePackages =
          (with pkgs; [
            gnome-photos
            gnome-tour
            gedit # text editor
          ])
          ++ (with pkgs.gnome; [
            cheese # webcam tool
            epiphany # web browser
            geary # email reader
            evince # document viewer
            totem # video player
            tali # poker game
            iagno # go game
            hitori # sudoku game
            atomix # puzzle game
          ]);

        environment.systemPackages = with pkgs; [
          gnome.gnome-tweaks
          gnomeExtensions.appindicator
          gnomeExtensions.auto-activities
          gnomeExtensions.gnome-40-ui-improvements
          gnomeExtensions.caffeine
        ];

        # todo: use home-manager to manager gnome extensions

        services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
      };
}
