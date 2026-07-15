{
  description = "Vizzion's NixOS configuration";
  inputs = {
    xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-26.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      flake-parts,
      self,
      nixpkgs,
      chaotic,
      spicetify-nix,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs spicetify-nix; };
        modules = [
          ./configuration.nix
          ./modules/niri.nix
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
                  ./home.nix
                ];
              };
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
