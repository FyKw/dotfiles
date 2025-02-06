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
                echo ${cfg.greeting}
                source $HOME/.config/fish/extraConfig.fish
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
            xdg.configFile."fish/extraConfig.fish" = lib.mkSymlink ./config.fish;
        };

        environment.sessionVariables.STARSHIP_CONFIG = "${inputs.self}/fish/starship.toml";
    };
}
