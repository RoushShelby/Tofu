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
          fish
        ];

        shellHook = ''
          echo "Quickly! Shell the Tofu!"
          exec fish
        '';
      };
  };
}