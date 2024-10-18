# 命令行提示表
# 默认快捷键: Ctrl+g
{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkDefault mkEnableOption;

  cfg = config.home.programs.navi;
in
{
  options.home.programs.navi = {
    enable = mkEnableOption "navi in home-manager";
  };

  config = {
    # 自动配置 navi 如果有 shell 想要调用它
    # 或者手动安装
    programs.navi = mkIf (config.home.programs.zsh.enableNavi || cfg.enable) {
      # 安装 navi 如果有 shell 调用它
      enable = mkDefault true; # 设置默认值，允许覆盖
      enableZshIntegration = mkIf config.home.programs.zsh.enableNavi true;
    };

    # 额外的包
    home.packages = mkIf config.programs.navi.enable (with pkgs; [ fzf ]);
  };
}
