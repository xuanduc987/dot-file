{ pkgs, ... }: {
  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
  ];
  environment.systemPackages = with pkgs; [ nix-direnv ];
  environment.pathsToLink = [
    "/share/nix-direnv"
  ];
}
