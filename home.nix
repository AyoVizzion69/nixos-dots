{ config, pkgs, ... }:

{
  home.username = "vizzion";
  home.homeDirectory = "/home/vizzion";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  programs.alacritty = {
    enable = true;
    settings = {
       window = {
       opacity = 0.8;  
    };
    colors = {
      primary = {
        background =  "#2b1a20";
        foreground = "#a6e3e9";
      };
    };
    };
  };
  programs.helix = {
  enable = true;
  settings = {
    theme = "rose_pine";
  };
};
  programs.foot = {
  enable = true;
  settings = {
    main = {
      font = "Terminus:size=11";
    };
    colors-dark = {
        alpha = "0.8";
        background = "191724";
        foreground = "e0def4";
      };
  };
};
  programs.zsh = {
    enable = true;
    shellAliases = {
      steam = "steam -cef-disable-gpu";
      btw = "echo nixos is tuff";
    };
  };
  home.file.".dwm/autostart.sh" = {
    source = ./config/dwm/autostart.sh;
    executable = true;
  };
  home.file.".config/fuzzel".source = ./config/fuzzel;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/fastfetch".source = ./config/fastfetch;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/sway".source = ./config/sway;
  home.packages = with pkgs; [
    fastfetch
    nil
    ripgrep
    nixpkgs-fmt
    nodejs
    gcc
  ];
}

