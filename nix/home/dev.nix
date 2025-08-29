{
  osConfig,
  lib,
  pkgs,
}: let
  cfg = osConfig.smgt;
in
  with lib; {
    config = mkIf cfg.dev.enable {
      packages = with pkgs; [
        entr
        buf
        glab
        # yaml-language-server
        # vscode-langservers-extracted
        # gopls
        # harper
        # terraform-ls
        # nil
        # rust-analyzer
        # nixd
        # hadolint
        # golangci-lint
        # checkmate
        # write-good
        # statix
        # semgrep
        # gosec
        # revive
        # checkmate
        # clippy
        # gofumpt
        # gotools
        # hclfmt
        # nixfmt-rfc-style
        # delve
        # impl
        # govulncheck
        # gomodifytags
        # gotestsum
      ];
    };
  }
