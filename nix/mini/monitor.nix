{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    grafana
    prometheus
    prometheus-node-exporter
  ];

  users.knownUsers = [ "grafana" ];
  users.knownGroups = [ "grafana" ];

  users.users.grafana = { uid = 550; gid = 550; name = "grafana"; home = "/var/lib/grafana"; createHome = true; shell = "/bin/bash"; };
  users.groups.grafana = { name = "grafana"; gid = 550; };

  launchd.daemons.grafana =
    {
      command = lib.concatStringsSep " \\\n  " [
        "${pkgs.grafana}/bin/grafana server"
        "--homepath=${pkgs.grafana}/share/grafana/"
        "cfg:default.paths.logs=/var/lib/grafana/log/grafana"
        "cfg:default.paths.data=/var/lib/grafana/data"
        "cfg:default.paths.plugins=/var/lib/grafana/data/plugins"
      ];
      serviceConfig = {
        RunAtLoad = true;
        GroupName = "grafana";
        UserName = "grafana";
        WorkingDirectory = "/var/lib/grafana";
      };
    };
  launchd.daemons.prometheus =
    let
      prometheus_yml = pkgs.writeText "prometheus.yml" ''
        global:
          scrape_interval: 15s

        scrape_configs:
          - job_name: "prometheus"
            static_configs:
            - targets: ["localhost:9090"]
          - job_name: "mac-mini"
            static_configs:
            - targets: ["localhost:9100"]
      '';
      command = lib.concatStringsSep " \\\n  " [
        "${pkgs.prometheus}/bin/prometheus"
        "--config.file=${prometheus_yml}"
        "--web.listen-address=127.0.0.1:9090"
        "--storage.tsdb.path /var/lib/prometheus/data"
      ];
    in
    {
      script = ''
        mkdir -p /var/lib/prometheus
        exec ${command}
      '';
      serviceConfig = {
        RunAtLoad = true;
        StandardOutPath = "/var/log/prometheus-stdout.log";
        StandardErrorPath = "/var/log/prometheus-stderr.log";
      };
    };
  launchd.daemons.prometheus-node-exporter =
    {
      command = lib.concatStringsSep " \\\n  " [
        "${pkgs.prometheus-node-exporter}/bin/node_exporter"
        "--web.listen-address=127.0.0.1:9100"
      ];
      serviceConfig = {
        RunAtLoad = true;
        StandardOutPath = "/var/log/prometheus-node-exporter-stdout.log";
        StandardErrorPath = "/var/log/prometheus-node-exporter-stderr.log";
      };
    };
}
