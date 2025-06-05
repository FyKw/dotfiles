{
    config,
    lib,
    pkgs,
    username,
    inputs,
    ...
}: let
in {
    modules.tmux.enable = true;
    modules.fish.enable = true;
    modules.fish.greeting = "Moin";
    modules.aliases.enable = true;
    modules.docker.enable = true;
    modules.git.enable = true;
    modules.vpn.enable =true;
    modules.win32yank.enable = true;
    modules.neovim.enable = true;

    wsl = {
        enable = true;
        wslConf = {
            automount.root = "/mnt";
            interop.appendWindowsPath = false;
            network.generateHosts = false;
            network.generateResolvConf = false; # business internet fix
        };
        defaultUser = username;
        startMenuLaunchers = true;
    };

    networking.nameservers = [
        "8.8.8.8"
        "1.1.1.1"
    ];
    home-manager.users.${username} = {
          home.stateVersion = "24.05";
    };
    home-manager.backupFileExtension = "hm-old";

    boot.tmp.cleanOnBoot = true;
    environment.systemPackages = with pkgs; [
        git
        neovim
        unzip
        gnumake
        gcc
        ripgrep
        asciiquarium-transparent
        # python311Full
        nodejs_20
        rustup
        librespeed-cli
        exiv2
        awscli2
        poetry
        git-lfs
        # (pkgs.writeShellScriptBin "vim-focus" ''
        #     pane_tty=$1
        #     pipenv_pid=$(pgrep -t ''${pane_tty/\/dev\/} .poetry-wrapped)
        #     if [[ $? == 0 ]]; then
        #       ps -o state=,comm= -p $(${pkgs.pstree}/bin/pstree -p $pipenv_pid | grep -Po '\(\d+\)' | tr -d '()')
        #     else
        #       ps -o state=,comm= -t $pane_tty
        #     fi | grep -qP '^[^TXZ] (view|nvim)$'
        # '')
    ];
    nix = {
        package = pkgs.nixVersions.stable;
        extraOptions = ''
            experimental-features = nix-command flakes pipe-operators
            !include /home/${username}/.nix.conf
        '';
    };

    users.users.${username} = {
        isNormalUser = true;
        extraGroups = ["wheel" "docker"];
    };

    time.timeZone = "Europe/Berlin";

    services.openssh.enable = true;
    programs.ssh.startAgent = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?
}
