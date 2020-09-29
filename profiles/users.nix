{ pkgs, lib, ... }:

let
  inherit (lib) optionalAttrs mkMerge mkIf mkDefault;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;
in

mkMerge [
  {
    home-manager.users.phil = (import ../config/home/default.nix);
    users.users.phil.home = mkIf isDarwin "/Users/phil";
  }

  (optionalAttrs isLinux {
    users.users.phil = {
      isNormalUser = true;
      uid = 1000;
      home = "/home/phil";
    };
  })
]
