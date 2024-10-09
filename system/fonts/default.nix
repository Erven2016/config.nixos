{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkIf
    mkOption
    mkMerge
    types
    ;

  cfg = config.custom-system.fonts;

  # Minimal fonts set
  must-have-fonts = with pkgs; [
    corefonts # Microsoft's TrueType core fonts for the Web
    # font list to display CJK and Emoji fonts.
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-color-emoji
    noto-fonts-emoji-blob-bin
  ];
in
{

  imports = [ ./nerdfonts.nix ];

  options.custom-system.fonts = {
    enable = mkOption {
      type = types.bool;
      default = true;
      example = false;
      description = "Enable font config;";
    };

    extra-fonts = mkOption {
      type = types.listOf types.package;
      default = [ ];
      example = [
        pkgs.noto-fonts
        pkgs.noto-fonts-cjk
      ];
      description = "Extra fonts list";
    };

    nerdfonts = mkOption {
      type = types.listOf types.str;
      default = [
        "FiraCode"
        "JetBrainsMono"
        "ibm-plex"
      ];
      example = [ ];
      description = "Nerdfonts override.";
    };

  };

  config = mkIf cfg.enable {

    # Fonts
    fonts = {
      enableDefaultPackages = true;
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      # packages = (mkIf config.custom-system.desktop.enable must-have-fonts) ++ cfg.extra-fonts;
      packages = mkMerge [
        (mkIf config.custom-system.desktop.enable (must-have-fonts))

        (cfg.extra-fonts)
      ];

      # todo: *
      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          monospace = [
            "Noto Sans Mono CJK SC"
            "Noto Color Emoji"
            "Sarasa Mono SC"
            "DejaVu Sans Mono"
          ];
          sansSerif = [
            "Noto Sans CJK SC"
            "Noto Color Emoji"
            "Source Han Sans SC"
            "DejaVu Sans"
          ];
          serif = [
            "Noto Serif CJK SC"
            "Noto Color Emoji"
            "Source Han Serif SC"
            "DejaVu Serif"
          ];
        };
      };
    };
  };
}
