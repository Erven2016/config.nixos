{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkOption;

  cfg = config;
  corefonts = with pkgs; [ ];
in
{
  imports = [ ];
  options.custom.fonts = {
    extraFonts = mkOption { };
  };
  config = { };
}
