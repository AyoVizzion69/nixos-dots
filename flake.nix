{
  description = "Vizzion's NixOS configuration";
  inputs = {
    # strict nix shit
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";

    # other stuff
    xlibre-overlay = {
      url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-26.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland/v0.56.0";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
   nixConfig = {
    extra-substituters = [
      "https://attic.xuyh0120.win/lantian"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    ];
  };

  outputs =
    {
      flake-parts,
      self,
      nixpkgs,
      chaotic,
      hyprland,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/hosts/t480-workstation
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          inputs.xlibre-overlay.nixosModules.overlay-xlibre-xserver
          inputs.xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.vizzion = {
                imports = [
                  ./modules/hosts/t480-workstation/home.nix
                ];
              };
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
