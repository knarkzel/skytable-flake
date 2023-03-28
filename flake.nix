{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
    version = "0.7.7";
  in {
    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      pname = "skytable";
      version = version;
      src = pkgs.fetchurl {
        url = "https://github.com/skytable/skytable/releases/download/v${version}/sky-bundle-v${version}-x86_64-linux-musl.zip";
        sha256 = "pKPX6B7nMhw32Vsc2L+ykdJPX2O86q379XGZx3Pni30=";
      };
      sourceRoot = ".";
      unpackCmd = "unzip sky-bundle-v${version}-x86_64-linux-musl.zip";
      buildInputs = [pkgs.unzip];
      installPhase = ''
        install -D ./skyd $out/bin/skyd
        install -D ./sky-bench $out/bin/sky-bench
        install -D ./sky-migrate $out/bin/sky-migrate
        install -D ./skysh $out/bin/skysh
      '';
      postInstall = ''
        wrapProgram "$out/bin/skyd"
        wrapProgram "$out/bin/sky-bench"
        wrapProgram "$out/bin/sky-migrate"
        wrapProgram "$out/bin/skysh"
      '';
    };
  };
}
