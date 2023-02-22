{ config, lib, pkgs, nixpkgs, ... }:
{
  # for build vim on mac
  nixpkgs.config.vim = { darwin = true; gui = false; };
  nixpkgs.config.netbeans = false;

  environment.systemPackages = with pkgs; [
    python3

    vim_configurable
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

