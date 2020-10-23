let
  inherit (import ../../nix/channels.nix) __nixPath;
  pkgs-unstable = import <nixpkgs-unstable> {};
  colors = import ../colors.nix;
in {
  home.packages = [ pkgs-unstable.kitty ];

  xdg.configFile."kitty/kitty.conf".text = ''
    # See ~/nix-system/config/kitty.nix
    font_family Dank Mono
    ${colors.kitty}
    cursor_blink_interval -1
    font_size 14.0
    hide_window_decorations yes
    scrollback_lines 0
    term xterm-256color
    clipboard_control write-clipboard write-primary no-append
  '';
}
