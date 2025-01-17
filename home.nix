{ pkgs, ... }:

{
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    terraform
    aws-vault

    git
    git-absorb
    git-branchless
    git-machete
    gitAndTools.gh
    ghq
    jujutsu

    efm-langserver
    # language server for nix
    nil
    nixpkgs-fmt

    unrar

    bun

    nodejs
    nodePackages.yarn
    nodePackages.prettier
    nodePackages.eslint_d
    pnpm

    awscli2
    fd
    fzf
    jq
    ripgrep
    tokei

    graphviz
    gnuplot
    yt-dlp
    irssi
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      g = "git";
      ga = "git add";
      gb = "git branch";
      gc = "git commit -v";
      "gc!" = "git commit -v --amend";
      "gcn!" = "git commit -v --no-edit --amend";
      gcb = "git checkout -b";
      gcm = "git checkout (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')";
      gco = "git checkout";
      gd = "git diff";
      gdca = "git diff --cached";
      gf = "git fetch";
      gfo = "git fetch origin";
      gignore = "git update-index --assume-unchanged";
      gunignore = "git update-index --no-assume-unchanged";
      gp = "git push";
      gr = "git remote";
      gwip = "git add -A; git rm (git ls-files --deleted) 2> /dev/null; git commit --no-verify -m '--wip-- [skip ci]'";
      gs = "git status";
      grs = "git reset";
      grb = "git rebase";
      gm = "git merge";
      gll = "git pull";

      rf = "ghq get -p";

      v = "nvim";
    };
    functions = {
      git-prune-merged-branches = ''git branch --merged main | grep -v "^\\* main" | xargs -n 1 -r git branch -d'';
      rj = ''cd (ghq list --full-path | fzf -1 -q "$argv[1]" )'';
      pr = ''
        switch $argv[1]
          case ""
            gh pr view -w || gh pr create -w
          case co
            gh pr list | fzf -q "$argv[2]" | awk '{print $1}' | xargs gh pr checkout
          case m
             gh pr merge -md $argv[2..-1]
          case '*'
            gh pr $argv
        end
      '';
      issue = ''
        switch $argv[1]
          case ""
            set -l issue_number (gh issue list --assignee "@me" | fzf -q "$argv[2]" | awk '{print $1}')
            if test -n "$issue_number"
              git checkout -b "duc/issue-$issue_number"
            end
          case '*'
            gh issue $argv
        end
      '';
    };
    shellInit = ''
      set -gx DIRENV_LOG_FORMAT

      set -gx FZF_DEFAULT_COMMAND 'fd --type file'
      set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
      set -gx FZF_ALT_C_COMMAND 'fd --type directory'


      # Ghostty Shell Integration
      if set -q GHOSTTY_RESOURCES_DIR
          source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
      end

      fish_add_path $HOME/bin
    '';
  };
}
