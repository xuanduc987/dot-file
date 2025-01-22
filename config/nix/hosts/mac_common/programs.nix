{pkgs, ...}: {
  disabledModules = ["programs/direnv.nix"];
  imports = [../../modules/direnv.nix];
  environment.systemPackages = with pkgs; [fzf fd];
  programs = {
    direnv = {
      enable = true;
      silent = true;
      enableZshIntegration = true;
    };
    fish = {
      enable = true;
      useBabelfish = true;
      shellInit = ''
        # fish alias is slow, use function instead
        function rf
          ghq get -p $argv
        end

        function v
          nvim $argv
        end

        # disable greeting
        set -g fish_greeting

        # Ghostty Shell Integration
        if set -q GHOSTTY_RESOURCES_DIR
            source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
        end

        set -gx FZF_DEFAULT_COMMAND 'fd --type file'
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
        set -gx FZF_ALT_C_COMMAND 'fd --type directory'
      '';
    };
  };
}
