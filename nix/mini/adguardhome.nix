{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    adguardhome
  ];
}
