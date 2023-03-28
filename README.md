# skytable-flake

```
$ nix flake show github:knarkzel/skytable-flake
└───packages
    └───x86_64-linux
        └───default: package 'skytable-0.7.7'
$ nix build github:knarkzel/skytable-flake
$ ./result/bin/skyd
[2023-03-28T20:17:54Z INFO  skyd] Skytable v0.7.7 | https://github.com/skytable/skytable
    
    ███████ ██   ██ ██    ██ ████████  █████  ██████  ██      ███████
    ██      ██  ██   ██  ██     ██    ██   ██ ██   ██ ██      ██
    ███████ █████     ████      ██    ███████ ██████  ██      █████
         ██ ██  ██     ██       ██    ██   ██ ██   ██ ██      ██
    ███████ ██   ██    ██       ██    ██   ██ ██████  ███████ ███████
    
[2023-03-28T20:17:54Z WARN  skyd] No configuration file supplied. Using default settings
[2023-03-28T20:17:54Z INFO  skyd::dbnet] Server started on skyhash://127.0.0.1:2003
```

## Minimal example

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    skytable-flake = {
      url = "github:knarkzel/skytable-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    skytable-flake,
  }: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
    skytable = skytable-flake.packages.x86_64-linux.default;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [skytable];
    };
  };
}
```
