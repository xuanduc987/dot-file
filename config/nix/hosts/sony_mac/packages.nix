{
  pkgs,
  pkgs-unstable,
  ...
}: let
  sorbet = pkgs.callPackage ../../packages/sorbet {};
in {
  fonts.packages = with pkgs-unstable; [
    maple-mono.NF-CN-unhinted
  ];
  environment.systemPackages = with pkgs; [
    gitAndTools.gh
    ghq

    nix-search-cli

    python3

    awscli2
    aws-vault

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
  ];
}
