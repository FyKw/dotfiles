{lib, pkgs, ...}:{
options.desktop.enable = lib.mkEnableOption "Stylix";
config = cfg:{
    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
        image = ./wallpaper.png;
        polarity = "dark";
        # eventuell cursor einrichten
        fonts = lib.mkIf cfg.desktop.enable {
        sizes.terminal = 14;
        monospace = {
            package = pkgs.nerdfonts.override {fonts = [
                "CascadiaCode"

            ];};
            name = "CaskaydiaCove NF";
    };
    };
    };
};
}
