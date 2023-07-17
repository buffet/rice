{
  inputs = {
    impermanence.url = "github:nix-community/impermanence";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apl386 = {
      url = "github:abrudz/APL386";
      flake = false;
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
      url = "github:nix-community/home-manager/release-23.05";
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

    vim-hy = {
      url = "github:hylang/vim-hy";
      flake = false;
    };

    vlime = {
      url = "github:vlime/vlime";
      flake = false;
    };
  };

  outputs = {
    agenix,
    home-manager,
    nur,
    nixpkgs-unstable,
    nixpkgs,
    ...
  } @ args: {
    nixosConfigurations = let
      mkSystem = system: module:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = args;
          modules = let
            overlay-unstable = final: prev: {
              unstable = nixpkgs-unstable.legacyPackages.${prev.system};
            };
          in [
            module

            agenix.nixosModules.default
            home-manager.nixosModule
            nur.nixosModules.nur
            ./common.nix
            ./impermanence.nix
            ./system.nix
            (_: {nixpkgs.overlays = [(import ./overlay args) overlay-unstable];})
          ];
        };
    in {
      alice = mkSystem "x86_64-linux" ./alice;
      fanya = mkSystem "x86_64-linux" ./fanya;
    };
  };
}
