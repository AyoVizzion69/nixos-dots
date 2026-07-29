{
  config,
  pkgs,
  inputs,
  lib,
  system,
  ...
}:

{
  imports = [
    ../..
    ./hardware-configuration.nix
  ];

  boot.loader.limine = {
    enable = true;
    enableEditor = true;
    maxGenerations = 10;
  };

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
  services.xserver.enable = false;
  services.xserver.displayManager.startx.enable = false;
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
    lix
    yt-dlp
    dmenu
    st
    scrot
    dino
    gimp
    cloudflared
    senpai
    cava
    yazi
    lavat
    cbonsai
    picom
    ffmpeg
    tree
    spotify
    grim
    discord
    foot
    vim
    helix
    obs-studio
    quickshell
    git
    python3
    mpv
    quodlibet-full
    feedr
    pavucontrol
    efibootmgr
    onefetch
    cmatrix
    opencode
    waybar
    pcmanfm
    gedit
    btop
    ani-cli
    luajit
    vscode
    tty-clock
    taisei
    nitch
    kew
    mako
    gnumake
    mangohud
    protonup-qt
    nicotine-plus
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


  programs.steam = {
    enable = true;
    gamescopeSession.enable = false;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
    intel-vaapi-driver  
    ];
  };

  services = {
    desktopManager.plasma6.enable = false;
    displayManager.ly.enable = true;
    openssh.enable = true;
  };

  system.stateVersion = "26.05";
}
