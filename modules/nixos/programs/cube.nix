{inputs, system, pkgs, ...}:
{
    environment.systemPackages = [
    inputs.cube.packages.${pkgs.system}.default
  ];
}
