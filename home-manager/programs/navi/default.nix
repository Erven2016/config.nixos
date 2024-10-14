# 命令行提示表
# 默认快捷键: Ctrl+g
{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkDefault;
in
{
  config = {
    # 自动配置 navi 如果有 shell 想要调用它
    programs.navi = mkIf (config.home.programs.zsh.enableNavi || false) {
      # 安装 navi 如果有 shell 调用它
      enable = mkDefault true; # 设置默认值，允许全局关闭
      enableZshIntegration = mkIf config.home.programs.zsh.enableNavi true;
    };

    # 额外的包
    home.packages = mkIf config.programs.navi.enable (with pkgs; [ fzf ]);
  };

}
