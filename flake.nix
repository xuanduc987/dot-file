{
  inputs = {
    old-nixpkgs.url = "github:NixOS/nixpkgs/23.05";
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { darwin, nixpkgs, nixpkgs-unstable, old-nixpkgs, home-manager, ... }:
    let
      commonConfiguration = { user, system, modules ? [ ] }: {
        inherit system;

        modules = [
          {
            services.tailscale = {
              package = nixpkgs-unstable.legacyPackages.${system}.tailscale;
            };
          }

          {
            nixpkgs.overlays = [
              (final: prev: {
                grafana = old-nixpkgs.legacyPackages.${system}.grafana;

                yabai = prev.yabai.overrideAttrs (_:_: {
                  version = "6.0.2";
                  src = final.fetchFromGitHub {
                    owner = "koekeishiya";
                    repo = "yabai";
                    rev = "v6.0.2";
                    hash = "sha256-VI7Gu5Y50Ed65ZUrseMXwmW/iovlRbAJGlPD7Ooajqw=";
                  };
                  env = {
                    # silence service.h error
                    NIX_CFLAGS_COMPILE = "-Wno-implicit-function-declaration";
                  };
                });
              })
            ];
          }

          ./nix/services/wsdd.nix

          ./configuration.nix
          ./system.nix
          ./services.nix
          ./systemPackages.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ./home.nix;
            users.users."${user}".home = "/Users/${user}";
          }
        ] ++ modules;
        specialArgs = { inherit nixpkgs; };
      };
    in
    {
      darwinConfigurations = {
        "Duc-MB" = darwin.lib.darwinSystem
          (commonConfiguration {
            user = "d.xuan.nghiem";
            system = "x86_64-darwin";
          });
        "Ducs-Mac-mini" = darwin.lib.darwinSystem
          (commonConfiguration
            {
              user = "duc";
              system = "x86_64-darwin";
              modules = [
                ./nix/mini/monitor.nix
                ./nix/mini/bazarr.nix

                ({ pkgs, ... }: {
                  services.wsdd.enable = true;
                  homebrew = {
                    enable = true;
                    casks = [ "jellyfin" "orbstack" "radarr" "prowlarr" "sonarr" ];
                  };
                  environment.systemPackages = with pkgs; [
                    tmux
                    aria2
                    caddy
                  ];
                })
              ];
            });
        "mb-air" = darwin.lib.darwinSystem
          (commonConfiguration { user = "duc"; system = "aarch64-darwin"; });
      };
    };
}


