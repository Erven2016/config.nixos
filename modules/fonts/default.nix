{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;

  # Minimal-Fonts set
  defaultFonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-extra
    noto-fonts-emoji
    noto-fonts-color-emoji
    noto-fonts-emoji-blob-bin
  ];

  cfg = config.custom.fonts;
in
{
  imports = [
    ./nerdfonts.nix
    ./extrafonts.nix
   ];
  options.custom.fonts = {
    extraFonts = mkOption { type = types.pkgList; };
    fontConfig = mkOption { };
  };
  config = { };
}
