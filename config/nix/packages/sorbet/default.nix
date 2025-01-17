{
  bundlerApp,
  defaultGemConfig,
  stdenv,
}:
bundlerApp {
  pname = "sorbet";
  gemdir = ./.;
  exes = ["srb"];
  gemConfig =
    defaultGemConfig
    // {
      # See https://github.com/nix-community/bundix/issues/71
      sorbet-static = attrs:
        if stdenv.isDarwin
        then {
          # Append the OS-specific version suffix
          version = attrs.version + "-universal-darwin";
          # Update the SHA256 accordingly
          source = attrs.source // {sha256 = "sha256-v/WNjiFXBneD0Plm6w9igOL28XR4vCHG9zACCa+DMM4=";};
        }
        else attrs;
    };

  meta = {
    description = "A fast, powerful type checker designed for Ruby";
    homepage = "https://sorbet.org";
    mainProgram = "srb";
  };
}
