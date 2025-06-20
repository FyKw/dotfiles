{
    username,
    pkgs,
    inputs,
    lib,
    ...
}: {
    options.greeting = lib.mkOption {
        type = lib.types.str;
        default = "Hello dev metal";
    };

    imports = [
        inputs.nix-index-database.nixosModules.nix-index
    ];

    config = cfg: {
        users.users.${username}.shell = pkgs.fish;

        programs.fish = {
            enable = true;
            interactiveShellInit = ''
                set -U fish_greeting ${cfg.greeting}
                zoxide init fish | source
                # use starship prompt
                starship init fish | source
                set -gx EDITOR nvim

                # Autostart tmux if not already in one
                if not set -q TMUX
                    exec tmux
                end
            '';
        };
        stylix.targets.fish.enable = false;
        environment.shells = [pkgs.fish];

        environment.systemPackages = with pkgs; [
            starship
            zoxide
        ];
        programs.nix-index.enable = true;
        programs.nix-index-database.comma.enable = true;
        programs.command-not-found.enable = false; # nix-index handles this

        home-manager.users.${username} = {config, ...}: {
            home.sessionVariables.SHELL = "etc/profiles/per-user/${username}/bin/fish";
            xdg.configFile."starship/starship.toml" = lib.mkSymlink ./starship.toml;
        };

        environment.sessionVariables.STARSHIP_CONFIG = "$HOME/.config/starship/starship.toml";
    };
}
