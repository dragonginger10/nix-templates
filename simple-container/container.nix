{ lib, self, ...}:
{
  boot.isContainer = true;

  # let 'nixos-version --json' know about the git revision
  system.configurationRevision = lib.mkIf (self ? rev) self.rev;

  networking = {
    useDHCP = false;
    firewall.allowedTCPPorts = [80];
  };

  # enable web server
  services.httpd = {
    enable = true;
    adminAddr = "test@example.com";
  };
}
