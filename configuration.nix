{ config, pkgs, inputs, lib, spicetify-nix, system, ... }:

{
  imports = [
    spicetify-nix.nixosModules.spicetify
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.grub = {
  efiSupport = true;
  device = "nodev";
  useOSProber = true;
  theme = inputs.nixos-grub-themes.packages.${pkgs.system}.minegrub;
  };
  
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

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
    gimp
    cloudflared
    cava
    lavat
    cbonsai
    spotify
    grim
    discord
    kitty
    neovim
    quickshell
    git
    python3
    spotify-player
    feedr
    pavucontrol
    onefetch
    cmatrix
    opencode
    fuzzel
    waybar
    xwayland-satellite
    thunar
    gedit
    swaybg
    btop
    brave
    ani-cli
    luajit
    vscode
    tty-clock
    steam-devices-udev-rules
    gnumake
    mangohud
    protonup-qt
  ];
 
  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    terminus_font
  ];

  security.rtkit.enable = true;
   services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.dwl.enable = true;

  programs.gamescope = {
      enable = true;
    capSysNice = true;
    };
  
  programs.steam = {
  enable = true;
  gamescopeSession.enable = true;
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
};

  hardware.graphics = {
  enable = true;
  enable32Bit = true;
};   

  services = {
    desktopManager.plasma6.enable = false;
    displayManager.ly.enable = true;
    openssh.enable = true;
  };

  system.stateVersion = "26.05";
}
