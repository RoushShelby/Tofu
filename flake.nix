{
  description = "Quickshelled Tofu";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # We still keep the official repo for the latest Quickshell binary
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, quickshell, ... }: {
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
          quickshell.packages.x86_64-linux.default
          matugen
          fish
          cava
          # Bluetooth Tools
          bluez   # For bluetoothctl (used by the widget to check status)
          blueman # For blueman-manager (the GUI the widget launches)
        ];

        shellHook = ''
          echo "Quickly! Shell the Tofu!"
          exec fish
        '';
      };
  };
}