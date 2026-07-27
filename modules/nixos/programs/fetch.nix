{pkgs, ...}:
{
  environment.systemPackages = [
    pkgs.fetch
  ];
}
