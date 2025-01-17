{
  nix-darwin,
  nixpkgs-unstable,
  ...
}:
nix-darwin.lib.darwinSystem rec {
  system = "x86_64-darwin";
  modules = [
    {
      _module.args = {
        pkgs-unstable = import nixpkgs-unstable {inherit system;};
      };
    }
    ../mac_common
    ../../../../nix/services/wsdd.nix
    ../../../../nix/mini/bazarr.nix
    ({pkgs, ...}: {
      services.wsdd.enable = true;
      homebrew = {
        casks = ["jellyfin" "radarr" "prowlarr" "sonarr"];
      };
      environment.systemPackages = with pkgs; [
        caddy
      ];
    })
  ];
}
