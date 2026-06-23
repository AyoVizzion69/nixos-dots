{ config, pkgs, ... }:


{
	home.username = "vizzion";
	home.homeDirectory = "/home/vizzion";
	programs.git.enable = true;
	home.stateVersion = "26.05";
	programs.zsh = {
	    enable = true;
	    shellAliases = {
	        btw = "echo nixos is tuff";
	};
     };
     home.file.".config/sway".source = ./config/sway;
     home.file.".config/nvim".source = ./config/nvim;
     home.file.".config/fuzzel".source = ./config/fuzzel;
     home.file.".config/foot".source = ./config/foot;
     home.file.".config/waybar".source = ./config/waybar;

     home.packages = with pkgs; [
     neovim
     nil
     ripgrep
     nixpkgs-fmt
     nodejs
     gcc
 ];
}
