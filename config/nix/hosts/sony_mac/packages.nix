{
  pkgs-unstable,
  pkgs,
  ...
}: let
  sorbet = pkgs.callPackage ../../packages/sorbet {};
in {
  environment. systemPackages = with pkgs; [
    pkgs-unstable.neovim
    pkgs-unstable.jujutsu

    git
    gitAndTools.gh
    ghq

    # language server for nix
    nixd
    alejandra # nix formatter

    sorbet
    ruby-lsp
    vtsls
    stylua
    efm-langserver
    vscode-langservers-extracted
    yaml-language-server
    lua-language-server

    nodejs
    pnpm
    fzf
    ripgrep
  ];

  environment.variables.EDITOR = "nvim";
  environment.variables.PAGER = "less -FRX";
}
