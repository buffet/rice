{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "8.8.8.8" ];
    defaultGateway = "54.38.156.1";
    defaultGateway6 = "";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce true;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="54.38.157.231"; prefixLength=32; }
        ];
        ipv6.addresses = [
          { address="fe80::f816:3eff:fe72:fbe8"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "54.38.156.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = "2001:41d0:701:1100::24df"; prefixLength = 32; } ];
      };
      
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="fa:16:3e:72:fb:e8", NAME="eth0"
    
  '';
}
