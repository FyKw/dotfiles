{
    description = "some flake for me";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        nixos-wsl = {
            url = "github:nix-community/NixOS-WSL";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        stylix.url = "github:danth/stylix/release-25.05";

        nix-index-database = {
            url = "github:nix-community/nix-index-database?rev=4ac3639cebb6286f1a68d015b80e9e0c6c869ce6";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        modulix = {
            url = "github:anders130/modulix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };
    outputs = inputs: {
        nixosConfigurations = inputs.modulix.lib.mkHosts {
            inherit inputs;
            flakePath = "/home/gvoo/.dotfiles";
            modulesPath = ./modules;
            helpers = inputs.home-manager.lib;
            sharedConfig = {
                imports = [
                    inputs.nixos-wsl.nixosModules.wsl
                    inputs.home-manager.nixosModules.home-manager
                    inputs.stylix.nixosModules.stylix
                ];
            };
            specialArgs = {
                username = "gvoo";
                # put in your specialArgs like above
            };
        };
    };
}
