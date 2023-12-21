{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { darwin, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      commonConfiguration = user: system: {
        inherit system;

        modules = [
          {
            nixpkgs.overlays = [
              (final: prev: {
                git-branchless = nixpkgs-unstable.legacyPackages.${system}.git-branchless;
                ffsend = nixpkgs-unstable.legacyPackages.${system}.ffsend;
              })
            ];
          }

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
        ];
        specialArgs = { inherit nixpkgs; };
      };
    in
    {
      darwinConfigurations = {
        "Duc-MB" = darwin.lib.darwinSystem (commonConfiguration "d.xuan.nghiem" "x86_64-darwin");
        "Ducs-Mac-mini" = darwin.lib.darwinSystem (commonConfiguration "duc" "x86_64-darwin");
        "mb-air" = darwin.lib.darwinSystem (commonConfiguration "duc" "aarch64-darwin");
      };
    };
}

