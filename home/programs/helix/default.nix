{
  lib, config, pkgs, ...
}: {
  options = {
    home.programs.helix = {
      enable = true;
    };
  };
}
