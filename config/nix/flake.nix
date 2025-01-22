{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    darwinConfigurations = {
      JPCC02X86ASJHD2 = import ./hosts/sony_mac inputs;
      Ducs-Mac-mini = import ./hosts/duc_mac_mini inputs;
    };
  };
}
