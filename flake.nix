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
    };
 
    outputs = inputs@{ self, nixpkgs, nixos-wsl, ... }: {
        nixosConfigurations = {
            NixWsl = nixpkgs.lib.nixosSystem {
		specialArgs = {
		    username = "nixos";
		};
                system = "x86_64-linux";
                modules = [
                    ./configuration.nix
                    nixos-wsl.nixosModules.wsl
		    inputs.home-manager.nixosModules.home-manager
                ];
            };
        };
    };
}
