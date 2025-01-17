{
  pkgs-unstable,
  pkgs,
  ...
}: {
  environment. systemPackages = with pkgs; [
    pkgs-unstable.neovim
    pkgs-unstable.jujutsu

    git

    # language server for nix
    nixd
    alejandra # nix formatter

    fzf
    ripgrep
  ];

  environment.variables.EDITOR = "nvim";
  environment.variables.PAGER = "less -FRX";
}
