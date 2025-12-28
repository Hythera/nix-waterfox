{
  description = "Nix implementation of Waterfox";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    {
      overlays.default = final: prev: {
        waterfox = prev.callPackage ./waterfox/default.nix {
          waterfox-unwrapped = prev.callPackage ./waterfox-unwrapped/default.nix { };
        };
        waterfox-bin = prev.callPackage ./waterfox-bin/default.nix {
          waterfox-bin-unwrapped = prev.callPackage ./waterfox-bin-unwrapped/default.nix { };
        };
        waterfox-bin-unwrapped = prev.callPackage ./waterfox-bin-unwrapped/default.nix { };
        waterfox-unwrapped = prev.callPackage ./waterfox-unwrapped/default.nix { };
      };
    }
    // (inputs.flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {
        packages = {
          waterfox = pkgs.waterfox;
          waterfox-bin = pkgs.waterfox-bin;
          waterfox-bin-unwrapped = pkgs.waterfox-bin-unwrapped;
          waterfox-unwrapped = pkgs.waterfox-unwrapped;
        };
      }
    ));
}
