{
    environment.shellAliases = {
        "nix dev" = "nix develop -c fish";
        "flake-rebuild" = "sudo nixos-rebuild switch --flake .#NixWsl";
    };
}
