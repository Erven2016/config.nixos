{
  description = "My personal NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-erven2016 = {
      url = "github:Erven2016/nur/master";
    };
    nur-erven2016-unstable = {
      url = "github:Erven2016/nur/unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    distro-grub-themes = {
      url = "github:AdisonCavani/distro-grub-themes/master";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      nur-erven2016,
      nur-erven2016-unstable,
      nixos-hardware,
      home-manager,
      distro-grub-themes,
      ...
    }:
    let
      genericModules = [
        (
          { config, pkgs, ... }:
          {
            nixpkgs.overlays = [
              overlay-nixpkgs-unstable
              overlay-nur-erven2016
              overlay-nur-erven2016-unstable
            ];
          }
        )
      ];

      # overlays
      overlay-nixpkgs-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (final) system;
          config.allowUnfree = true;
          config.nvidia.acceptLicense = true;
        };
      };
      overlay-nur-erven2016 = final: prev: {
        nur-erven2016 = import nur-erven2016 {
          # inherit (final) system;
          # config.allowUnfree = true;
        };
      };
      overlay-nur-erven2016-unstable = final: prev: {
        nur-erven2016-unstable = import nur-erven2016-unstable {
          # inherit (final) system;
          # config.allowUnfree = true;
        };
      };
    in
    {
      # HP HP EliteBook 845 14 inch G11 Notebook PC
      nixosConfigurations."HP-5CG4172X6B" = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit system inputs;
        };
        modules = genericModules ++ [
          ./configuration.nix
          ./hosts/HP-5CG4172X6B.nix

          nixos-hardware.nixosModules.common-cpu-amd
          # nixos-hardware.nixosModules.common-cpu-amd-pstate
          # nixos-hardware.nixosModules.common-cpu-amd-zenpower
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-hidpi

          # Home Manager
          home-manager.nixosModules.home-manager
          ./home
          ./home/erven2016.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # home-manager.users.erven2016 = import ./home/erven2016.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }

        ];
      };
    };
}
