{username, lib, pkgs,  ... }: {
    home-manager.users.${username}.xdg.configFile.nvim = lib.mkSymlink ./.;
    environment.systemPackages = with pkgs; [
    	neovim
	gcc
	ripgrep
    ];
}
