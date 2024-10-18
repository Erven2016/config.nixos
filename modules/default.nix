{
  imports = [
    ./overlays
    ./flatpak
    ./sound
    ./fonts
    ./bootloader
    ./kvm

    # test purpose
    # todo: improve this
    ./power-management/suspend-then-hibernate.nix
  ];
}
