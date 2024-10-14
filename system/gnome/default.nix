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

        services.sysprof.enable = true;

        # excludePackages
        environment.gnome.excludePackages =
          (with pkgs; [
            gnome-tour # 使用向导
            gnome-console # replaced with gnome-terminal
            gedit # text editor
          ])
          ++ (with pkgs.gnome; [
            # 一些小游戏
            tali # poker game
            iagno # go game
            hitori # sudoku game
            atomix # puzzle game

            # I don't like it because it will stuck sometime when installing something!!!
            # Using `flatpak` command to manage flatpak applications in terminal is better
            gnome-software
          ]);

        environment.systemPackages = with pkgs; [
          gnome.gnome-tweaks
          gnome.gnome-terminal
          gnomeExtensions.appindicator
          gnomeExtensions.auto-activities
          gnomeExtensions.gnome-40-ui-improvements
          gnomeExtensions.caffeine
          gnomeExtensions.dock-from-dash
          gnomeExtensions.alphabetical-app-grid
          gnomeExtensions.just-perfection
        ];

        services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
      };
}
