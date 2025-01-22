{
  imports = [
    {
      nixpkgs.overlays = [
        # https://github.com/NixOS/nixpkgs/issues/402079
        (self: super: {
          nodejs = super.nodejs_22;
          nodejs-slim = super.nodejs-slim_22;
        })
      ];
    }
    ./configuration.nix
    ./packages.nix
    ./programs.nix
    ./homebrew.nix
  ];
}
