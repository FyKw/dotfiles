{internalName, ...}:{
    environment.shellAliases = {
        "nix-dev" = "nix develop -c fish";
        "flake-rebuild" = "sudo nixos-rebuild switch --flake .#${internalName}";
        "imgData" = "exiv2";
        "n" = "nvim .";
    };
}
