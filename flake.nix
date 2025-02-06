{

  description = "Trying out flake!";
  
  inputs = {
    nixpkgsStable.url = "nixpkgs/nixos-24.11";
    #home-manager.url = "github:nix-community/home-manager/release-24.05";
    #home-manager.inputs.nixpkgs.follows = "nixpkgsStable"; # looks for same version of packages
    nixpkgsUnstable.url = "nixpkgs/nixos-unstable";
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz"; # uncomment line for solaar version 1.1.13
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgsStable";
    };
  };
  
  outputs = { self, nixpkgsStable, nixpkgsUnstable, home-manager, solaar,... } @ inputs:
    let
      lib = nixpkgsStable.lib; # It is like pass nixpkgs to this var
      system = "x86_64-linux";
      #lib-un = inputs.nixpkgUnstable.lib;
      pkgs = nixpkgsStable.legacyPackages.${system};
      pkgsUnstable = nixpkgsUnstable.legacyPackages.${system};
    in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;        
	  modules = [ 
      ./configuration.nix 
      solaar.nixosModules.default
      ];
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
