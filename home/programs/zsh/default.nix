{ lib, config, ... }:
let
  inherit (lib) mkOption types;

  cfg = config.custom-home.zsh;
in
{
  options.custom-home.zsh = {
    enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = "Enable ZSH SHELL;";
    };
  };
  config = {
    programs.zsh = {
      enable = cfg.enable;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "sudo"
          "git"
        ];
        theme = "gentoo";
      };

      sessionVariables = {
        HTTP_PROXY = "http://localhost:7890";
        HTTPS_PROXY = "http://localhost:7890";
        http_proxy = "http://localhost:7890";
        https_proxy = "http://localhost:7890";
      };

      shellAliases = {
        q = "zellij delete-session kitty --force";
      };
    };
  };
}
