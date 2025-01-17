{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = ["homebrew/cask-fonts"];
    casks = [
      "ghostty"
      "font-commit-mono"
    ];
  };
}
