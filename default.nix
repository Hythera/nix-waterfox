{
  pkgs ? import <nixpkgs> { },
}:
rec {
  waterfox = pkgs.callPackage ./waterfox { inherit waterfox-unwrapped; };
  waterfox-bin = pkgs.callPackage ./waterfox-bin { inherit waterfox-bin-unwrapped; };
  waterfox-bin-unwrapped = pkgs.callPackage ./waterfox-bin-unwrapped { };
  waterfox-unwrapped = pkgs.callPackage ./waterfox-unwrapped { };
}
