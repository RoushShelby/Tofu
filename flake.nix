{
  description = "Quickshelled Tofu - A modular Waybar-style status bar for Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, quickshell, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      
      mkPkgs = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkQuickshellPackage = system:
        let
          pkgs = mkPkgs system;
          quickshellPkg = quickshell.packages.${system}.default;
          
          # Define fonts to include (Using corrected kebab-case name)
          fontPkgs = with pkgs; [
             nerd-fonts.code-new-roman
             nerd-fonts.symbols-only
          ];
        in
        pkgs.stdenv.mkDerivation {
          pname = "quickshell-tofu";
          version = "1.0.0";

          src = ./config;

          nativeBuildInputs = with pkgs; [ makeWrapper ];

          buildInputs = [ quickshellPkg ] ++ fontPkgs;

          installPhase = ''
            mkdir -p $out/share/quickshell-tofu
            mkdir -p $out/bin

            # Copy config files
            cp -r quickshell $out/share/quickshell-tofu/
            cp -r matugen $out/share/quickshell-tofu/

            # Create wrapper script
            cat > $out/bin/quickshell-tofu << 'EOF'
            #!/usr/bin/env bash
            
            TOFU_CONFIG="$HOME/.config/quickshell-tofu"
            TOFU_SHARE="@out@/share/quickshell-tofu"
            
            export XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
            
            mkdir -p "$TOFU_CONFIG"
            
            # Install config on first run
            if [ ! -d "$TOFU_CONFIG/quickshell" ] || [ ! -d "$TOFU_CONFIG/matugen" ]; then
              echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
              echo "  Installing Quickshell Tofu configuration..."
              echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
              
              if [ -d "$TOFU_SHARE/quickshell" ] && [ ! -d "$TOFU_CONFIG/quickshell" ]; then
                echo "→ Installing Quickshell config..."
                cp -r "$TOFU_SHARE/quickshell" "$TOFU_CONFIG/"
                echo "  ✓ Quickshell config installed"
              fi
              
              if [ -d "$TOFU_SHARE/matugen" ] && [ ! -d "$TOFU_CONFIG/matugen" ]; then
                echo "→ Installing Matugen templates..."
                cp -r "$TOFU_SHARE/matugen" "$TOFU_CONFIG/"
                echo "  ✓ Matugen templates installed"
              fi
              
              echo "→ Setting permissions..."
              find "$TOFU_CONFIG" -type d -exec chmod 755 {} \; 2>/dev/null || true
              find "$TOFU_CONFIG" -type f -exec chmod 644 {} \; 2>/dev/null || true
              echo "  ✓ Permissions set"
              
              echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
              echo "  ✓ Configuration installed to: $TOFU_CONFIG"
              echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
              echo ""
            fi
            
            # Run quickshell with the config
            exec @quickshell@/bin/quickshell -c "$TOFU_CONFIG/quickshell/default" "$@"
            EOF
            
            chmod +x $out/bin/quickshell-tofu
            
            # Substitute paths
            substituteInPlace $out/bin/quickshell-tofu \
              --replace '@out@' "$out" \
              --replace '@quickshell@' "${quickshellPkg}"
          '';

          meta = with pkgs.lib; {
            description = "A modular Waybar-style status bar for Hyprland using Quickshell";
            homepage = "https://github.com/yourusername/quickshell-rice";
            license = licenses.mit;
            platforms = platforms.linux;
            maintainers = [];
          };
        };
    in
    {
      packages = forAllSystems (system: {
        default = mkQuickshellPackage system;
      });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/quickshell-tofu";
        };
      });

      homeManagerModules = {
        default = import ./modules/home;
        quickshell = import ./modules/home/quickshell.nix;
        matugen = import ./modules/home/matugen.nix;
      };

      devShells = forAllSystems (system:
        let
          pkgs = mkPkgs system;
          quickshellPkg = quickshell.packages.${system}.default;
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              quickshellPkg
              matugen
              fish
              cava
              bluez
              blueman
              # Fix: Use correct kebab-case attribute
              nerd-fonts.code-new-roman
            ];

            shellHook = ''
              echo "Quickly! Shell the Tofu!"
              echo ""
              echo "Available commands:"
              echo "  quickshell -c config/quickshell/default    # Run Quickshell"
              echo "  ./scripts/apply-theme.sh <wallpaper>       # Apply theme"
              echo ""
              
              # Fix: Point to the correct package path in font config
              export FONTCONFIG_FILE=${pkgs.makeFontsConf { fontDirectories = [ pkgs.nerd-fonts.code-new-roman ]; }}
              
              exec fish
            '';
          };
        }
      );
    };
}