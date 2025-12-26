# Quickshell Rice

Modular Quickshell rice powered by Matugen for NixOS/Home Manager.

## Quick Start
```nix
{
  inputs.quickshell-rice.url = "github:yourusername/quickshell-rice";
  
  outputs = { self, nixpkgs, home-manager, quickshell-rice, ... }: {
    homeConfigurations.youruser = home-manager.lib.homeManagerConfiguration {
      modules = [
        quickshell-rice.homeManagerModules.default
        {
          rice.enable = true;
        }
      ];
    };
  };
}
```

## Iterate on Quickshell configs

Edit files in `config/quickshell/` then:
```bash
systemctl --user restart quickshell
```

Or for live reloading, run `quickshell` directly in a terminal.
