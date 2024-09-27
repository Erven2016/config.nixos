{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkOption
    types
    mkIf
    mkDefault
    mkMerge
    ;

  cfg = config.custom-home.programs.helix;
in
{
  options = {
    custom-home.programs.helix = {
      enable = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = "Enable helix editor.";
      };

      lsp = {

        # Rust Lsp Options
        rust = {
          enable = mkOption {
            type = types.bool;
            default = false;
            example = true;
            description = "Enbale rust support for helix.";
          };
          autoFormat = mkOption {
            type = types.bool;
            default = false;
            example = true;
            description = "Enable formating when saving rust files.";
          };
        };

        nix = {
          enable = mkOption {
            type = types.bool;
            default = true;
            example = false;
            description = "Enable nix support.";
          };
        };

        yaml = {
          enable = mkOption {
            type = types.bool;
            default = true;
            example = false;
            description = "Enable yaml lsp support.";
          };
        };

        toml = { };

        bash = { };

        python = { };
      };
    };
  };

  config = {
    programs.helix.enable = cfg.enable;

    programs.helix = {
      defaultEditor = true;
      settings = {
        theme = "github_dark_tritanopia_transparent";
        editor = {
          mouse = mkDefault false;
          cursorline = true;
          auto-format = false;
          color-modes = true;
          default-line-ending = "lf";
          popup-border = "all";
          bufferline = mkDefault "multiple";

          indent-guides = {
            render = true;
            character = "▏";
            skip-levels = 1;
          };

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
          auto-format = false;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
        {
          name = "yaml";
          auto-format = false;
          formatter = mkIf cfg.lsp.yaml.enable {
            command = "yamlfmt";
            args = [ "-" ];
          };
        }
        # Shell
        {
          name = "bash";
          auto-format = false;
          formatter = {
            command = "shfmt";
            args = [
              # simplify and minimize code
              # visit for more details: 
              # https://github.com/mvdan/sh/blob/master/cmd/shfmt/shfmt.1.scd
              "-s"
              "-mn"
              "-"
            ];
          };
        }
      ];

      extraPackages = mkMerge [
        (mkIf (cfg.lsp.rust.enable) (
          with pkgs;
          [
            rustup
            lldb
          ]
        ))

        (mkIf (cfg.lsp.nix.enable) (
          with pkgs;
          [
            nil
            nixfmt-rfc-style
          ]
        ))

        (mkIf (cfg.lsp.yaml.enable) (
          with pkgs;
          [
            yaml-language-server
            yamlfmt
          ]
        ))

        (with pkgs; [
          nodePackages.bash-language-server
          shfmt
        ])
      ];
    };

    xdg.configFile."helix/themes/github_dark_tritanopia_transparent.toml" = {
      text = ''
        inherits = "github_dark_tritanopia"
        "ui.background" = {}
      '';
    };
  };
}
