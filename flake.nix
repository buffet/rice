{
  inputs = {
    impermanence.url = "github:nix-community/impermanence";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lsp-trouble = {
      url = "github:simrat39/lsp-trouble.nvim";
      flake = false;
    };
  };

  outputs = {nixpkgs, ...} @ args: {
    nixosConfigurations.fanya = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = args;
      modules = [./fanya.nix];
    };
  };
}
