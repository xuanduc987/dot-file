{
  nix-darwin,
  nixpkgs-unstable,
  ...
}:
nix-darwin.lib.darwinSystem rec {
  system = "x86_64-darwin";
  modules = [
    ./configuration.nix
    ./packages.nix
    ./programs.nix
    ./homebrew.nix
  ];
  specialArgs = {
    pkgs-unstable = import nixpkgs-unstable {inherit system;};
  };
}
