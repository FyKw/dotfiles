{username, ...}:
{
    home-manager.users.${username}.programs.kitty = {
        enable = true;
        settings = {
            confirm_os_window_close = 0;
            cursor_trail = 3;
            cursor_trail_decay = "0.1 0.4";
            hide_window_decorations = "yes";
            placement_strategy = "top-left";
            bell_path = "none";
            enable_audio_bell = "no";
            disable_ligatures = "always";
        };
    };
}
