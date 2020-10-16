{ config, lib, ... }:

let

  inherit (import ./channels.nix) __nixPath nixPath;
  inherit (lib) mkForce;
  inherit (lib.systems.elaborate { system = builtins.currentSystem; }) isLinux isDarwin;

in

rec {
  nixpkgs = {
    overlays = import <nixpkgs-overlays>;
    config.allowUnfree = true;
  };

  nix.nixPath = mkForce nixPath;

  _module.args =
    let

      pkgsConf = {
        inherit (config.nixpkgs) localSystem crossSystem;
        overlays = config.nixpkgs.overlays ++ nixpkgs.overlays;
        config = config.nixpkgs.config // nixpkgs.config;
      };

    in

    rec {
      pkgs = import <nixpkgs> (
        if isLinux then {
          inherit (pkgsConf) overlays config localSystem crossSystem;
        } else {
          inherit (pkgsConf) overlays config;
        }
      );

      pkgs-unstable = import <nixpkgs-unstable> (
        if isLinux then {
          inherit (pkgsConf) overlays config localSystem crossSystem;
        } else {
          inherit (pkgsConf) overlays config;
        }
      );
    };
}
