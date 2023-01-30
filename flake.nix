{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs, ... }:
    let
      commonConfiguration = {
        modules = [
          ./configuration.nix
          ./system.nix
          ./services.nix
          ./systemPackages.nix

          ./nix-direnv.nix
        ];
        specialArgs = { inherit nixpkgs; };
      };
    in
    {
      darwinConfigurations = {
        "Duc-MB" = darwin.lib.darwinSystem (commonConfiguration // { system = "x86_64-darwin"; });
        "mb-air" = darwin.lib.darwinSystem (commonConfiguration // { system = "aarch64-darwin"; });
      };
    };
}
