{
  vars,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.smgt.dev;
in
  with lib; {
    options.smgt.dev.enable = mkOption {
      default = false;
      type = lib.types.bool;
      description = "enable or disable";
    };
    config = mkIf cfg.enable {
      programs = {
        awscli.enable = true;

        murp = {
          enable = true;
          jira.ticketQuery = vars.murp.jira.ticketQuery;
          gitlab.reviewers = vars.murp.gitlab.reviewers;
        };

        # enable go
        go = {
          enable = true;
          goPrivate = vars.go.private;
        };

        # Enable direnv and nix-direnv
        direnv = {
          enable = true;
          nix-direnv.enable = true;
          enableZshIntegration = true;
          config = {
            global = {
              warn_timeout = "5m";
            };
          };
        };
      };

      home = {
        packages = with pkgs; [
          entr
          buf
          glab
          gopls
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
    };
  }
