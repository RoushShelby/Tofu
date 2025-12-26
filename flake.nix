{
  description = "Quickshelled Tofu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    homeManagerModules = {
      default = import ./modules/home;
      quickshell = import ./modules/home/quickshell.nix;
      matugen = import ./modules/home/matugen.nix;
    };

    devShells.x86_64-linux.default = 
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      pkgs.mkShell {
        packages = with pkgs; [
          quickshell
          matugen
        ];

        shellHook = ''
          echo "Quickshell development environment loaded"
          echo ""
          echo "Available commands:"
          echo "  quickshell -c config/quickshell/shell.qml  - Run Quickshell"
          echo "  matugen image <path>                        - Generate theme"
          echo ""
          echo "Quick start:"
          echo "  ./scripts/apply-theme.sh /path/to/wallpaper.png"
        '';
      };
  };
}