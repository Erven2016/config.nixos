{ lib, pkgs, ... }:
let
  inherit (lib) mkDefault;
in
{
  users.users = {
    erven2016 = {
      isNormalUser = true;
      extraGroups = [
        "docker"
        "wheel"
        "networkmanager"
      ];
      # packages = with pkgs; [ rustup v2raya ];
    };
  };

  home-manager.users.erven2016 = {

    # must import in home-manager user scope
    imports = [ ./module-list.nix ];

    home.username = "erven2016";
    home.homeDirectory = "/home/erven2016";

    home.desktop.gnome.extension.enable = true;

    home.programs.kitty.enable = true;
    home.programs.kitty.startWithZellij = true;

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

    home.packages = with pkgs; [
      lazygit
      google-chrome
    ];

    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "github_dark_tritanopia";
        editor = {
          mouse = mkDefault false;
          cursorline = true;
          auto-format = false;
          color-modes = true;
          default-line-ending = "lf";
          popup-border = "all";

          lsp = {
            enable = true;
            display-messages = true;
          };

          cursor-shape = {
            normal = "block";
            insert = "bar";
            select = "underline";
          };

        };

        keys.normal = {
          space.i = ":format";
        };
      };

      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
      ];

      extraPackages = with pkgs; [
        nil
        nixfmt-rfc-style
      ];
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
