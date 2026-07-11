{ config, pkgs, ... }:

{
  home.username = "vizzion";
  home.homeDirectory = "/home/vizzion";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  programs.foot = {
  enable = true;
  settings = {
    main = {
      font = "JetBrainsMono Nerdfont:size=10";
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
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/fuzzel".source = ./config/fuzzel;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/fastfetch".source = ./config/fastfetch;
  home.file.".config/kitty".source = ./config/kitty;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/sway".source = ./config/sway;
  home.packages = with pkgs; [
    fastfetch
    neovim
    nil
    ripgrep
    nixpkgs-fmt
    nodejs
    gcc
  ];
}

