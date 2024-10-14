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
    mkEnableOption
    # types
    mkDefault
    mkMerge
    ;

  cfg = config.home.programs.zsh;
in
{
  options.home.programs.zsh = {
    enable = mkEnableOption "zsh";

    # navi: 终端命令提示表
    enableNavi = mkEnableOption "navi for zsh";
  };

  config = {
    # 设置默认值
    home.programs.zsh.enable = mkDefault true; # 默认安装 zsh
    home.programs.zsh.enableNavi = mkDefault true; # 默认安装 navi

    # zsh 配置
    programs.zsh = mkIf cfg.enable {
      oh-my-zsh = {
        # 这个值要写死，只能从 home.programs.zsh.enable 改
        enable = cfg.enable;
        plugins = mkDefault [
          "sudo"
          "git"
        ];
        theme = mkDefault "gentoo";
      };

      sessionVariables = { };

      shellAliases = { };

      # initExtra = mkMerge [ (mkIf cfg.enableNavi "eval \"\$(navi widget zsh)\"") ];
    };

    # 额外的包
    # home.packages = mkMerge [
    #   (mkIf cfg.enableNavi (with pkgs; [ navi ]))
    #   (mkIf cfg.enableNavi (with pkgs; [ fzf ]))
    # ];
  };
}
