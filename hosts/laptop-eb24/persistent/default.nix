# Note: needing to mount persistent block to /persistent
{ inputs, ... }:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  config = {
    environment.persistence."/persistent" = {
      hideMounts = true;

      directories = [
        # to keep connections' information of NetworkManager
        "/etc/NetworkManager/system-connections"
        # to keep users' home directory
        "/home"
        # to keep root's home directory
        "/root"
        # to keep data files or logging files of system and programs
        "/var"
      ];

      files = [
        # to keep the machine-id generated by Systemd
        "/etc/machine-id"

        # to keep ssh keys generated by OpenSSH
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
      ];
    };
  };
}