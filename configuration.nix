{ config, lib, pkgs, nixpkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ (final: prev: { nodejs = prev.nodejs-14_x; }) ];

  nix.registry.nixpkgs.flake = nixpkgs;

  nix.package = pkgs.nix;
  nix.configureBuildUsers = true;

  nix.gc = {
    automatic = true;
    interval = { Hour = 20; Minute = 10; Weekday = 7; };
    options = "--delete-older-than 30d";
  };

  services.nix-daemon.enable = true;

  environment.variables.EDITOR = "vim";

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    extra-experimental-features = nix-command flakes
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
