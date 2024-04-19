{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    git-branchless.url = "github:xuanduc987/git-branchless";
  };

  outputs = { darwin, nixpkgs, nixpkgs-unstable, home-manager, git-branchless, ... }:
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
              git-branchless.overlays.default
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

            modules = [
              {
                system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = 7.0;

                homebrew = {
                  enable = true;
                  casks = [
                    "seafile-client"
                    "obsidian"
                    "karabiner-elements"
                    "orbstack"
                  ];
                };
              }
            ];
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


