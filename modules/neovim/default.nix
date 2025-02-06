{username, lib, ... }: {
    home-manager.users.${username}.xdg.configFile.nvim = lib.mkSymlink ./.;
}
