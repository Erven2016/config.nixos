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
            description = "Enable nix support for nix";
          };
        };
      };
    };
  };

  config = {
    programs.helix.enable = cfg.enable;

    programs.helix = {
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
      ];
    };
  };
}
