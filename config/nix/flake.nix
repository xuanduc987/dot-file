{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
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
