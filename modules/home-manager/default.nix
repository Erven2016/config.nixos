# home-manager common configuration
{ ... }:
{
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # Optionally, use home-manager.extraSpecialArgs to pass arguments
  };

}
