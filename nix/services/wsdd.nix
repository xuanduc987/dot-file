{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.wsdd;
in
{
  options.services.wsdd = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.wsdd ];

    launchd.user.agents.wsdd = {
      command = "${pkgs.wsdd}/bin/wsdd";
      serviceConfig.RunAtLoad = true;
      serviceConfig.KeepAlive = true;
    };
  };
}
