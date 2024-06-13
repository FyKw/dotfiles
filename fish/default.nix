{username, pkgs, inputs, ...}:{
users.users.${username} = {
    shell = pkgs.fish;
};
    programs.fish.enable = true;
    environment.shells = [pkgs.fish];

    environment.systemPackages = with pkgs;[
        starship
        zoxide
];
    home-manager.users.${username} = { config, ... }: {
       home.sessionVariables.SHELL = "etc/profiles/per-user/${username}/bin/fish";
        xdg.configFile."fish/config.fish" = {
	    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/fish/config.fish";
	};
    };

    environment.sessionVariables.STARSHIP_CONFIG = "${inputs.self}/fish/starship.toml";
}
