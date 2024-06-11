# NixOS

# Installation

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

```
ln -s /home/simon/.dotfiles/machines/<MACHINE>/configuration.nix /etc/nixos/configuration.nix
```

Install the system.

```
nixos-install \
  --root "/mnt" \
  --no-root-passwd
```

# Install home-manager

https://nix-community.github.io/home-manager/#sec-install-standalone

```console
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
```

# Investigate

- https://github.com/nix-community/disko
- https://github.com/notthebee/nix-config/tree/main
