# Nix

## Home-manager standalone

```
home-manager build --flake ~/.dotfiles/#<hostname>
home-manager switch --flake ~/.dotfiles/#<hostname>
```

## NixOS

### Installation

After booting the installation media for NixOS create a root password using.

```
sudo su
passwd
```

From the host, add your ssh key and continue installation via SSH.

```
ssh-copy-id -i ~/.ssh/id_ed25519 root@<IP>
ssh root@<IP>
```

Enable nix experimental features.

```
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

Clone this repository.

```
mkdir -p /mnt/home/simon
git clone https://git.0xee.cc/smgt/dotfiles.git .dotfiles
```

Link the correct machine configuration in the system.

    ln -s /home/simon/.dotfiles/nix/machines/<MACHINE>/configuration.nix /etc/nixos/configuration.nix

Add required channels.

```console
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# or
nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager

nix-channel --update
```

Install the system.

```
nixos-install \
  --root "/mnt" \
  --no-root-passwd
```

### Install home-manager

https://nix-community.github.io/home-manager/#sec-install-standalone

### Run config

```console
nixos-rebuild switch
```

# Investigate

- https://github.com/nix-community/disko
- https://github.com/notthebee/nix-config/tree/main

# Housekeeping

## Remove old generations

When you make changes to your system, Nix creates a new system Generation. All of the changes to the system since the previous generation are stored there. Old generations can add up and will not be removed automatically by default. You can see your generations with:

    $ nix-env --list-generations

To keep just your current generation and the two older than it:

    $ nix-env --delete-generations +3

To remove all but your current generation:

    $ nix-env --delete-generations old

### Generation trimmer script

For a smart interactive script which can handle all the normally available profile types across NixOS and be more conservative and safe than the built-in Nix generations deletion commands, see NixOS Generations Trimmer.

## Garbage collection

As you work with your system (installs, uninstalls, upgrades), files in the Nix store are not automatically removed, even when no longer needed. Nix instead has a garbage collector which must be run periodically (you could set up, e.g., a cron to do this).

    $ nix-collect-garbage

This is safe so long as everything you need is listed in an existing generation or garbage collector root (gcroot).

If you are sure you only need your current generation, this will delete all old generations and then do garbage collection:

    $ nix-collect-garbage -d

On NixOS, you can enable a service to automatically do daily garbage collection:

`/etc/nixos/configuration.nix`

    nix.gc.automatic = true;

