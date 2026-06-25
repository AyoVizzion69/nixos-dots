{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  # Window Manager
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Doas Configuration
  security.sudo.enable = false;
  security.doas.enable = true;
  security.doas.extraRules = [
    {
      users = [ "vizzion" ];
      keepEnv = true;
      persist = true;
    }
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "docker"
        "npm"
      ];
    };
  };

  users.users."vizzion" = {
    isNormalUser = true;
    description = "vizzion";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    spotify
    grim
    discord
    steam
    foot
    noctalia-shell
    neovim
    quickshell
    git
    pfetch
    tealdeer
    bat
    ghostty
    cmatrix
    brave
    fuzzel
    waybar
    xwayland-satellite
    thunar
    mako
    autotiling
    gedit
    swaybg
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services = {
    desktopManager.plasma6.enable = false;
    displayManager.ly.enable = true;
    openssh.enable = true;
  };

  system.stateVersion = "26.05";
}
