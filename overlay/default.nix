inputs: self: super: {
  inherit inputs;

  apl386 = super.callPackage ./apl386 {};
  fennel-ls = super.callPackage ./fennel-ls {};
}
