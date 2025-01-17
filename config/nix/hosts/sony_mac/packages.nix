{pkgs, ...}: let
  sorbet = pkgs.callPackage ../../packages/sorbet {};
in {
  environment. systemPackages = with pkgs; [
    gitAndTools.gh
    ghq

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
