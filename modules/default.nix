{ lib, options, ... }:
{
  imports = [
    ./desktop
    ./programs
  ];

  options = {
    buffet.home = lib.mkOption {
      type = options.home-manager.users.type.functor.wrapped;
    };
  };

  config = {
    buffet.home = {
      programs.home-manager.enable = true;
    };
  };
}
