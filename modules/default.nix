{
  imports = [
    ./overlays
    ./flatpak
    ./sound
    ./fonts
    ./bootloader
    ./kvm

    # development
    ./nodejs

    # test purpose
    # todo: improve this
    ./power-management/suspend-then-hibernate.nix
  ];
}
