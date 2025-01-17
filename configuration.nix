{ pkgs, nixpkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix.registry.nixpkgs-unstable.to = {
    type = "github";
    owner = "NixOS";
    repo = "nixpkgs";
    ref = "nixpkgs-unstable";
  };

  nix.package = pkgs.nix;
  nix.configureBuildUsers = true;

  nix.gc = {
    automatic = true;
    interval = { Hour = 20; Minute = 10; Weekday = 7; };
    options = "--delete-older-than 30d";
  };

  services.nix-daemon.enable = true;

  environment.variables.EDITOR = "vim";
  environment.variables.PAGER = "less -FRX";

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    extra-experimental-features = nix-command flakes
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
}
