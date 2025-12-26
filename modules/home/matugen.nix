{ pkgs, lib, config, ... }:

lib.mkIf config.rice.enable {
  home.packages = [ pkgs.matugen ];

  xdg.configFile."matugen" = {
    source = ../../config/matugen;
    recursive = true;
  };
}
