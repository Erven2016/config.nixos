{ ... }:
{
  options = { };
  config = {
    programs.zellij.enable = true;
    programs.zellij.settings = {
      keybinds = {
        unbind = [ "Ctrl q" ];
      };
    };
  };
}
