{ username, ... }: {
    home-manager.users.${username} = { config, ... }: {
        xdg.configFile.nvim = {
	    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/neovim";
	    recursive = true;
	};
    };
}
