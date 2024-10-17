{
  imports = [
    ./overlays
    ./flatpak
    ./sound
    ./fonts
    ./bootloader

    # test purpose
    # todo: improve this
    ./power-management/suspend-then-hibernate.nix
  ];
}
