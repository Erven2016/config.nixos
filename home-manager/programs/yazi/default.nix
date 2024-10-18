{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;

  cfg = config.home.programs.yazi;
in
{
  options.home.programs.yazi = {
    enable = mkEnableOption "yazi in home-manager";
  };
  config = {
    programs.yazi = {
      enable = mkIf (config.home.programs.zsh.enableYazi || cfg.enable) true;
    };
  };
}
