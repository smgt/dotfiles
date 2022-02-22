# 1Password setup

Setup 1password in Arch linux.

## Installation

Install `1password-cli` and `1password`.

## 2FA

If you have 2fa enabled in 1Password you will need a keyring to save the 2fa for a little while. Otherwise you will need to authenticate with the 2fa token/key all the time.

Install `gnome-keyring` with `yay -S gnome-keyring`.

Enable the keyring during pam login by editing `/etc/pam.d/login` and add `auth optional pam_gnome_keyring.so` as the last auth option and `session optional pam_gnome_keyring.so auto_start` as the last session option.

Example:

```
#%PAM-1.0

auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-local-login
auth       optional     pam_gnome_keyring.so
account    include      system-local-login
session    include      system-local-login
session    optional     pam_gnome_keyring.so auto_start
password   include      system-local-login
```

## SSH keys

With `bin/1p-ssh` you can store and load ssh-keys into your ssh-agent.
