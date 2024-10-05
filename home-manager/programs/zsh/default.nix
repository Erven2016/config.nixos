{ lib, config, ... }:
let
  inherit (lib) mkOption types mkDefault;
in
{
  config = {
    programs.zsh = {
      oh-my-zsh = {
        enable = mkDefault true;
        plugins = mkDefault [
          "sudo"
          "git"
        ];
        theme = mkDefault "gentoo";
      };

      sessionVariables = { };

      shellAliases = { };
    };
  };
}
