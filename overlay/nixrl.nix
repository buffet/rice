{ perl, writeScriptBin }:
writeScriptBin "nixrl" ''
  #!${perl}/bin/perl

  use strict;
  use warnings;

  use Getopt::Std;
  use Sys::Hostname;

  my %opts;
  getopts('a:m:', \%opts);

  my $config = $ENV{"NIXOS_CONFIG"} // "/etc/nixos";
  my $action = $opts{"a"} // "switch";
  my $machine = $opts{"m"} // hostname;

  my $machinepath = "$config/machines/$machine";

  -d $machinepath
    or die "Couldn't find $machinepath";

  exec "nixos-rebuild", "-I", "machine=$machinepath", $action;
''
