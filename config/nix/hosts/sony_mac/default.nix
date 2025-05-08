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
      system.primaryUser = "d.xuan.nghiem";
    }
    ../mac_common
    ./configuration.nix
    ./packages.nix
    ./services.nix
    ./homebrew.nix
  ];
}
