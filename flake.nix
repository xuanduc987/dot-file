{
  inputs = {
    # yabai and skhd failed to build on 23.11
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    # home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { darwin, nixpkgs, home-manager, ... }:
    let
      commonConfiguration = { user, system, modules ? [ ] }: {
        inherit system;

        modules = [
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
                ({ pkgs, ... }: {
                  services.wsdd.enable = true;
                  homebrew = {
                    enable = true;
                    casks = [ "jellyfin" ];
                  };
                  environment.systemPackages = with pkgs; [ tmux aria2 ];
                })
              ];
            });
        "mb-air" = darwin.lib.darwinSystem
          (commonConfiguration { user = "duc"; system = "aarch64-darwin"; });
      };
    };
}


