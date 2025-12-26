{ pkgs, lib, config, ... }:

lib.mkIf config.rice.enable {
  home.packages = [ pkgs.quickshell ];

  xdg.configFile."quickshell" = {
    source = ../../config/quickshell;
    recursive = true;
  };
}
