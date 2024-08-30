{ pkgs, ... }:
{
  users.users = {
    erven2016 = {
      isNormalUser = true;
      extraGroups = [
        "docker"
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.zsh;
    };
  };

  home-manager.users.erven2016 = {

    # must import in home-manager user scope
    imports = [ ./module-list.nix ];

    # Custom packages
    home.packages = with pkgs; [
      lazygit
      dust
      hugo
      google-chrome
      vscode
    ];

    home.username = "erven2016";
    home.homeDirectory = "/home/erven2016";

    home.desktop.gnome.extension.enable = true;

    home.programs.kitty.enable = true;
    home.programs.kitty.startWithZellij = true;

    custom-home.programs.helix.enable = true;
    custom-home.programs.helix.lsp = {
      rust.enable = true;
    };

    custom-home.zsh.enable = true;

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Custom
    programs.zellij.enable = true;

    # git config
    programs.git = {
      enable = true;
      userName = "Erven2016";
      userEmail = "leiguihua2016@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "24.05";
  };
}
