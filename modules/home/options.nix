{ lib, ... }:

{
  options.rice = {
    enable = lib.mkEnableOption "Enable Quickshell";

    wallpaper = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
    };

    bar = {
      position = lib.mkOption {
        type = lib.types.enum [ "top" "bottom" ];
        default = "top";
      };
    };
  };
}
