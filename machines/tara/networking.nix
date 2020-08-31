{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [
      "213.186.33.99"
    ];
    defaultGateway = "51.75.64.1";
    defaultGateway6 = "2001:41d0:701:1100::1";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce true;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="51.75.65.33"; prefixLength=32; }
        ];
        ipv6.addresses = [
          { address="2001:41d0:701:1100::2b72"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "51.75.64.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = "2001:41d0:701:1100::2b72"; prefixLength = 32; } ];
      };
      
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="fa:16:3e:03:34:cb", NAME="eth0"
    
  '';
}
