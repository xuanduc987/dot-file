{ pkgs, ... }: {
  services.lorri.enable = true;

  services.tailscale = {
    enable = true;
  };

  services.yabai = {
    enable = true;
    config = {
      layout = "bsp";
      split_ratio = 0.62;
      top_padding = 8;
      bottom_padding = 8;
      left_padding = 8;
      right_padding = 8;
      window_gap = 8;

      mouse_follows_focus = "off";
      focus_follows_mouse = "off";

      window_animation_duration = 0.0;
      window_opacity_duration = 0.0;
      window_shadow = "float";
    };
    extraConfig = ''
      yabai -m rule --add app="(System Preferences|Screen Sharing|Activity Monitor|System Settings|mpv|Chrome|Telegram|XD|Spotify|TeamViewer|Sequel Ace)" manage=off
      yabai -m rule --add app="Thunderbird" title=".+ Reminders?" manage=off
      yabai -m rule --add app="Stata.*" title="Graph.*" manage=off
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig =
      let kitty = if pkgs.stdenv.hostPlatform.isAarch64 then "/opt/homebrew/bin/kitty" else "/usr/local/bin/kitty";
      in
      ''
        cmd - return : ${kitty} --single-instance --working-directory $HOME

        # focus window
        cmd + ctrl - h : yabai -m window --focus west
        cmd + ctrl - j : yabai -m window --focus south
        cmd + ctrl - k : yabai -m window --focus north
        cmd + ctrl - l : yabai -m window --focus east

        # swap managed window
        cmd + alt - h : yabai -m window --swap west
        cmd + alt - j : yabai -m window --swap south
        cmd + alt - k : yabai -m window --swap north
        cmd + alt - l : yabai -m window --swap east

        # move managed window
        cmd + ctrl + shift - h : yabai -m window --warp west
        cmd + ctrl + shift - j : yabai -m window --warp south
        cmd + ctrl + shift - k : yabai -m window --warp north
        cmd + ctrl + shift - l : yabai -m window --warp east

        # stacking windows
        alt - s : yabai -m window --stack next
        alt - tab : yabai -m window --focus stack.next || yabai -m window --focus stack.first
        alt + shift - p : yabai -m window --focus stack.prev || yabai -m window --focus prev || yabai -m window --focus last
        alt + shift - n : yabai -m window --focus stack.next || yabai -m window --focus next || yabai -m window --focus first

        # float / unfloat window and center on screen
        alt - t : yabai -m window --toggle float; yabai -m window --grid 10:8:1:1:6:8
      '';
  };
}
