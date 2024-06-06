{ config, pkgs, ...}:

{
  imports = [
    ../../home-manager
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    aggressiveResize = true;
    clock24 = true;
    keyMode = "vi";
    mouse = false;
    prefix = "C-a";
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.fzf-tmux-url
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.sensible
    ];
  };

  programs.home-manager.enable = true;
}
