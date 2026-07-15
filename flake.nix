{
  description = "Vizzion's NixOS configuration";
  inputs = {
    # strict nix shit
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
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
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
