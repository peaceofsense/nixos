{

  description = "Trying out flake!";
  
  inputs = {
    nixpkgsStable.url = "nixpkgs/nixos-24.05";
    #home-manager.url = "github:nix-community/home-manager/release-24.05";
    #home-manager.inputs.nixpkgs.follows = "nixpkgsStable"; # looks for same version of packages
    nixpkgsUnstable.url = "nixpkgs/nixos-unstable";
  };
  
  outputs = { self, nixpkgsStable, nixpkgsUnstable, home-manager, ... } @ inputs:
    let
      lib = nixpkgsStable.lib; # It is like pass nixpkgs to this var
      system = "x86_64-linux";
      #lib-un = inputs.nixpkgUnstable.lib;
      pkgs = nixpkgsStable.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;        
	modules = [ ./configuration.nix ];
      };
    };
  #  homeConfigurations = {
  #    peaceofsense = home-manager.lib.homeManagerConfiguration {
  #      inherit pkgs;
	#modules = [ ./home.nix ]; 
  #    };
  #  };
  };

}
