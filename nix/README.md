# NixOS

# Setup

Link the correct machine configuration in the system.

`ln -s /home/simon/.dotfiles/machines/leek/configuration.nix /etc/nixos/configuration.nix`


Install home-manager

https://nix-community.github.io/home-manager/#sec-install-standalone

```console
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
```
