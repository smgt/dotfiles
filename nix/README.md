# Nix

## Home-manager standalone

```
home-manager build --flake ~/.dotfiles/#<hostname>
home-manager switch --flake ~/.dotfiles/#<hostname>
```

## NixOS

### Installation on hardware

### Build ISO

```sh
# Inside the nix/ directory
export NIX_PATH=nixos-config=$PWD/iso.nix:nixpkgs=channel:nixos-25.05
nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage
```

This will result in a ISO with settings from the `iso.nix` file. After the
build is done you can write the ISO image to a USB stick or similar. The build
command will output the Nix store path and it will also be available in
`./result/iso/`.

### Boot and provision

Boot the ISO on the new system, find the host name and provision the device
using
[nixos-anywhere](https://github.com/nix-community/nixos-anywhere/blob/main/docs/quickstart.md).

First create a configuration for the system in `machines/[name]/default.nix`.
Then add the system to `flake.nix`. After that is done you can provision the device.
We also generate the hardware configuration for the system.

```sh
# Example with disk encryption
nix run github:nix-community/nixos-anywhere -- \
  --flake .#[system name]\
  --disk-encryption-keys /tmp/secret.key <(cat /secret/password) \
  --generate-hardware-config nixos-generate-config nix/machines/[system name]/hardware-configuration.nix \
  --target-host simon@[ip address]

# Example without disk encryption
nix run github:nix-community/nixos-anywhere -- \
  --flake .#[system name]\
  --generate-hardware-config nixos-generate-config nix/machines/[system name]/hardware-configuration.nix \
  --target-host simon@[ip address]
```

Reboot the system.

### Making changes to a system

Update a remote system.

```sh 
nix run nixpkgs#nixos-rebuild -- \
  --target-host simon@[hostname] \
  --use-remote-sudo \
  switch \
  --flake .#[system name]
```

Update a local system

```sh
sudo nixos-rebuild switch --flake .#[systemname]
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

