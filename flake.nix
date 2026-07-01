{
  description = "A very basic flake";
  inputs = {
    zen-browser.url = "github:youwen5/zen-browser-flake";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    nixos-grub-themes.url = "github:jeslie0/nixos-grub-themes";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    wrappers.url = "github:BirdeeHub/nix-wrapper-modules";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    helium = {
  url = "github:schembriaiden/helium-browser-nix-flake";
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
