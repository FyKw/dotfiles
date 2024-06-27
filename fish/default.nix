{username, pkgs, inputs, ...}:{
users.users.${username} = {
    shell = pkgs.fish;
};
    imports = [
        inputs.nix-index-database.nixosModules.nix-index
        ];
    programs.fish.enable = true;
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
        xdg.configFile."fish/config.fish" = {
	    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/fish/config.fish";
	};
    };

    environment.sessionVariables.STARSHIP_CONFIG = "${inputs.self}/fish/starship.toml";
}
