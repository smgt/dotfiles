# YOD Yet Another Dotfile

This is the collection of my dotfiles. I don't use much but I do love the cli so I try to stick to it as much as possible. These dotfiles were onces adapted for OSX but nowdays they are tailored for Arch Linux. I try to keep the cli parts portable to Debian flavours.

I'm using zsh + tmux + neovim. They are the heavy lifters. I also use asdf to manage some software especially programming languages.

I do like browsing the web so I need firefox. That means I also use xorg with i3. I run i3 + polybar + dunst + rofi.

This page is more of a documentation for me since I seem to forget all the time.

# Setup

## Set X11 keymaps

```
localectl --no-convert set-x11-keymap us,se grp:alt_shift_toggle
```
