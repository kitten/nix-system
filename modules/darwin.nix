{ options, pkgs, ... }:

{
  system.stateVersion = 3;
  # Disable path verification of $NIX_PATH
  system.checks.verifyNixPath = false;
  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # Auto-configure build users
  users.nix.configureBuildUsers = true;
  # Manage Nix package via channels
  nix.package = pkgs.nix;
}
