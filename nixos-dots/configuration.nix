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
    /etc/nixos/hardware-configuration.nix
  ];

  boot.loader.limine = {
    enable = true;
    enableEditor = true;
    maxGenerations = 10;
  };

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

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
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };
  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.dwm.enable = true;
  services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
    src = ./config/dwm;
    patches = [
      ./config/dwm/patches/dwm-cfacts-vanitygaps-6.4_combo.diff
      ./config/dwm/patches/dwm-autostart-20210120-cb3f58a.diff
      ./config/dwm/patches/dwm-status2d.diff
    ];
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
    lix
    yt-dlp
    dmenu
    st
    vivaldi
    scrot
    dino
    gimp
    cloudflared
    senpai
    alacritty
    cava
    yazi
    lavat
    cbonsai
    xdpyinfo
    picom
    ffmpeg
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
    feh
    feedr
    pavucontrol
    efibootmgr
    onefetch
    cmatrix
    opencode
    fuzzel
    waybar
    pcmanfm
    gedit
    swaybg
    btop
    ani-cli
    luajit
    vscode
    tty-clock
    steam-devices-udev-rules
    jp2a
    taisei
    rofi
    nitch
    kew
    mako
    gnumake
    swayfx
    autotiling
    cozette
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

  nix.settings.trusted-users = [ "vizzion" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
