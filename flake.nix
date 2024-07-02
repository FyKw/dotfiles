{
    description = "A very basic flake with nodejs";
 
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixos-wsl = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
	home-manager = {
            url = "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix";

        nix-index-database = {
            url = "github:nix-community/nix-index-database?rev=4ac3639cebb6286f1a68d015b80e9e0c6c869ce6";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
 
    outputs = inputs@{ self, nixpkgs, nixos-wsl, ... }: {
        nixosConfigurations = {
            NixWsl = nixpkgs.lib.nixosSystem {
		specialArgs = {
		    username = "nixos";
                    inherit inputs;
		};
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    nixos-wsl.nixosModules.wsl
		    inputs.home-manager.nixosModules.home-manager
                    inputs.stylix.nixosModules.stylix
                ];
            };
        };
    };
}
