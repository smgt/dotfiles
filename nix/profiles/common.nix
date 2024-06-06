{ config, pkgs, lib, ... }:
{
  # Set zsh as default shell
  users.defaultUserShell = pkgs.zsh;

  programs = {
    zsh = {
      enable = true;
      setOptions = [
        "NO_BG_NICE" # don't nice background tasks
        "NO_HUP"
        "NO_LIST_BEEP"
        "LOCAL_OPTIONS" # allow functions to have local options
        "LOCAL_TRAPS" # allow functions to have local traps
        "HIST_VERIFY"
        "EXTENDED_HISTORY" # add timestamps to history
        "PROMPT_SUBST"
        "COMPLETE_IN_WORD"
        "IGNORE_EOF"

        # Share history between sessions
        "APPEND_HISTORY" # adds history
        "INC_APPEND_HISTORY"
        "SHARE_HISTORY"  # adds history incrementally and share it across sessions
        "HIST_REDUCE_BLANKS"
      ];
    };
  };
}
