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
      "font-commit-mono-nerd-font"
    ];
  };

  programs.fish = {
    enable = true;
    useBabelfish = true;
    babelfishPackage = pkgs.babelfish;
  };

  programs.zsh.enable = true;
}

