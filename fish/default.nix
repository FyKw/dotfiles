{username, pkgs, inputs, ...}:{
users.users.${username} = {
    shell = pkgs.fish;
};
    imports = [
        inputs.nix-index-database.nixosModules.nix-index
        ];

    programs.fish = {
        enable = true;
        interactiveShellInit = /*fish*/''
            source /home/${username}/.dotfiles/fish/config.fish
        '';
    };
    stylix.targets.fish.enable = false;
    environment.shells = [pkgs.fish];

    environment.systemPackages = with pkgs;[
        starship
        zoxide
];
        programs.nix-index.enable = true;
        programs.nix-index-database.comma.enable = true;
        programs.command-not-found.enable = false; # nix-index handles this

    home-manager.users.${username} = { config, ... }: {
       home.sessionVariables.SHELL = "etc/profiles/per-user/${username}/bin/fish";
    };

    environment.sessionVariables.STARSHIP_CONFIG = "${inputs.self}/fish/starship.toml";
}
