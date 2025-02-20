{

  description = "Working flake?";
  
  inputs = {
    nixpkgsStable.url = "nixpkgs/nixos-24.11"; # Change this to update version
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
      username = "peaceofsense";
    in {
    nixosConfigurations = {
      monolith = lib.nixosSystem { # System Name
        inherit system;        
	      modules = [ ./configuration.nix solaar.nixosModules.default ];
        specialArgs = {
          inherit username;
          inherit pkgsUnstable;
        };
      };
    };
  };

}
