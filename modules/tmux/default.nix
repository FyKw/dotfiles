{ lib, pkgs, username, ... }: {
    programs.tmux = {
        enable = true;
        escapeTime = 0;
        keyMode = "vi";
        shortcut = "Space";
        secureSocket = false;
        plugins = with pkgs.tmuxPlugins; [
            vim-tmux-navigator
            onedark-theme
        ];
        extraConfigBeforePlugins = ''
            source-file /home/${username}/.config/tmux/tmux.conf
        '';
    };

    home-manager.users.${username}.xdg.configFile."tmux/tmux.conf" = lib.mkSymlink ./tmux.conf;
}
