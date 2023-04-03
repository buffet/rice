{
  inputs = {
    impermanence.url = "github:nix-community/impermanence";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nur.url = "github:nix-community/NUR";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    cmp-conventionalcommits = {
      url = "github:davidsierradz/cmp-conventionalcommits";
      flake = false;
    };

    cmp-git = {
      url = "github:petertriho/cmp-git";
      flake = false;
    };

    copilot-cmp = {
      url = "github:zbirenbaum/copilot-cmp";
      flake = false;
    };

    copilot-lua = {
      url = "github:zbirenbaum/copilot.lua";
      flake = false;
    };

    gh-nvim = {
      url = "github:ldelossa/gh.nvim";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvim-cmp-vlime = {
      url = "gitlab:HiPhish/nvim-cmp-vlime";
      flake = false;
    };

    # work around for nixpkgs version being too old
    rust-tools-nvim = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };

    vlime = {
      url = "github:vlime/vlime";
      flake = false;
    };
  };

  outputs = {nixpkgs, ...} @ args: {
    nixosConfigurations.fanya = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = args;
      modules = [
        ./fanya.nix

        (_: {nixpkgs.overlays = [(import ./overlay)];})
      ];
    };
  };
}
