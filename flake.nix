{

  description = "Trying out flake!";
  
  inputs = {
    nixpkgsStable.url = "nixpkgs/nixos-24.05";
    nixpkgsUnstable.url = "nixpkgs/nixos-unstable";
  };
  
  outputs = { self, nixpkgsStable, nixpkgsUnstable, ... } @ inputs:
    let
      lib = nixpkgsStable.lib; # It is like pass nixpkgs to this file
      #lib-un = inputs.nixpkgUnstable.lib;
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };
  };

}
