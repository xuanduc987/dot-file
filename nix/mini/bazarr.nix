{ ... }: {
  homebrew = {
    enable = true;
    brews = [ "bazarr" ];
  };

  launchd.user.agents.bazarr = {
    serviceConfig = {
      ProgramArguments = [
        "/bin/sh"
        "-c"
        "/bin/wait4path /usr/local/bin/bazarr &amp;&amp; /usr/local/bin/bazarr"
      ];
      RunAtLoad = true;
    };
  };
}

