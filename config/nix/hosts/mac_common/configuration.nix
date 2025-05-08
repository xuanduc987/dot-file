{
  lib,
  config,
  ...
}:
lib.mkMerge [
  {
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

    security.pam.services.sudo_local.touchIdAuth = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 5;
  }
  (lib.mkIf config.nix.enable {
    services.nix-daemon.enable = true;

    nix.gc = {
      automatic = true;
      interval = {
        Hour = 20;
        Minute = 10;
        Weekday = 7;
      };
      options = "--delete-older-than 30d";
    };

    nix.registry.nixpkgs-unstable.to = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    nix.settings = {
      experimental-features = "nix-command flakes";
      trusted-users = [
        "root"
        "@admin"
      ];
    };
  })
]
