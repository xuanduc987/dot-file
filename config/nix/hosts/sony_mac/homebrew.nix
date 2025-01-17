{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    brews = ["watchman"];
    taps = ["homebrew/cask-fonts"];
    casks = [
      "anki"
      "netnewswire"

      "teamviewer"

      "google-chrome"

      "ghostty"
      "kitty"
      "raycast"
      "rectangle"
      "sensiblesidebuttons"
      "shottr"
      "alt-tab"
      "swiftbar"
      "itsycal"
      "seafile-client"

      "orbstack"
      "sequel-ace"
      "zotero"

      "font-commit-mono"
    ];
  };
}
