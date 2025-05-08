{lib, ...}: {
  # Displays have separate Spaces = false
  system.defaults.spaces.spans-displays = true;
  services.aerospace = let
    floatting = appId: {
      "if".app-id = appId;
      check-further-callbacks = true;
      run = "layout floating";
    };
    makeFloatting = builtins.map floatting;
    openAtWorkspace = workspace: appId: {
      "if".app-id = appId;
      check-further-callbacks = true;
      run = "move-node-to-workspace ${workspace}";
    };
    makeOpenAtWorkspace = workspaceSet:
      builtins.concatLists (lib.mapAttrsToList (workspace: appIds: builtins.map (openAtWorkspace workspace) appIds)
        workspaceSet);
  in {
    enable = true;
    settings = {
      gaps = {
        inner.horizontal = 6;
        inner.vertical = 6;
        outer.left = 6;
        outer.bottom = 6;
        outer.top = 6;
        outer.right = 6;
      };
      on-window-detected =
        makeFloatting [
          "cc.ffitch.shottr"
          "com.apple.finder"
          "com.apple.ScreenSharing"
          "com.mitchellh.ghostty"
          "ru.keepcoder.Telegram"
          "tv.plex.plexamp"
          "com.rsa.securid.iphone.SecurID"
          "com.cisco.secureclient.gui"
          "com.vng.zalo"
        ]
        ++ makeOpenAtWorkspace {
          "2" = ["com.apple.Safari"];
          "3" = ["com.tinyspeck.slackmacgap"];
          "4" = ["com.apple.mail"];
        };
      mode.main.binding = {
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-shift-f = "layout floating tiling";

        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        alt-ctrl-h = "join-with left";
        alt-ctrl-j = "join-with down";
        alt-ctrl-k = "join-with up";
        alt-ctrl-l = "join-with right";

        alt-minus = "resize smart -50";
        alt-equal = "resize smart +50";

        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";
        alt-shift-7 = "move-node-to-workspace 7";
        alt-shift-8 = "move-node-to-workspace 8";
        alt-shift-9 = "move-node-to-workspace 9";

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        alt-shift-semicolon = "mode service";
      };
      mode.service.binding = {
        esc = ["reload-config" "mode main"];
        r = ["flatten-workspace-tree" "mode main"]; # reset layout
        backspace = ["close-all-windows-but-current" "mode main"];
      };
    };
  };
}
