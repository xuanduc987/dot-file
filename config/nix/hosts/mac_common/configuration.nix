{
  nix.gc = {
    automatic = true;
    interval = {
      Hour = 20;
      Minute = 10;
      Weekday = 7;
    };
    options = "--delete-older-than 30d";
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [
      "root"
      "@admin"
    ];
  };

  services.nix-daemon.enable = true;

  system.defaults = {
    NSGlobalDomain.AppleFontSmoothing = 2;
    NSGlobalDomain.AppleShowAllExtensions = true;

    NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
    NSGlobalDomain.AppleShowScrollBars = "Always";

    dock.orientation = "left";
    dock.tilesize = 36;

    NSGlobalDomain.InitialKeyRepeat = 25;
    NSGlobalDomain.KeyRepeat = 2;
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
