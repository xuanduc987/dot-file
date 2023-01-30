{ config, lib, pkgs, nixpkgs, ... }:
{
  # for build vim on mac
  nixpkgs.config.vim = { darwin = true; gui = false; };
  nixpkgs.config.netbeans = false;

  environment.systemPackages = with pkgs; [
    git-branchless
    git-absorb
    mosh

    niv
    direnv
    lorri
    nil
    nixpkgs-fmt

    python3

    ripgrep
    fd
    fzf
    jq
    tokei

    vim_configurable

    efm-langserver

    fish

    ghq
    gitAndTools.gh
    git-machete

    gnuplot

    yt-dlp

    deno
    bun

    nodejs
    nodePackages.yarn
    nodePackages.prettier
    nodePackages.eslint_d
    nodePackages.pnpm

    tmux
    awscli2

    unrar

    irssi
  ];

  homebrew = {
    enable = true;

    brews = [
      "watchman"
    ];

    casks = [
      "alt-tab"
      "anki"
      "itsycal"
      "kitty"
      "mpv"
      "raycast"
      "sensiblesidebuttons"
      "shottr"

      "font-juliamono"
    ];
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
    babelfishPackage = pkgs.babelfish;
  };
}

