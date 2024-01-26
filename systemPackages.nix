{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mosh
    watchman
    python3
    vim-darwin
  ];

  homebrew = {
    enable = true;

    taps = [
      "homebrew/cask-fonts"
    ];

    brews = [ ];

    casks = [
      "alt-tab"
      "anki"
      "kitty"
      "mpv"
      "raycast"
      "sensiblesidebuttons"
      "shottr"

      "swiftbar"
      "itsycal"

      "font-juliamono"
      "font-commit-mono"
    ];
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
    babelfishPackage = pkgs.babelfish;
  };
}

