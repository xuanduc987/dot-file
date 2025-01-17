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
    ./packages.nix
    ./homebrew.nix
  ];
}
