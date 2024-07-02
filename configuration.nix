{ config, lib, pkgs, username, inputs, ... }: let
in {
imports = [
  ./vpn.nix
  ./docker.nix
  ./neovim
  ./fish
  ./aliases.nix

];
wsl = {
        enable = true;
        wslConf = {
            automount.root = "/mnt";
            interop.appendWindowsPath = false;
            network.generateHosts = false;
            network.generateResolvConf = false; # business internet fix
        };
        defaultUser = "nixos";  
        startMenuLaunchers = true;
    };

  networking.nameservers = [
	"8.8.8.8"
	"1.1.1.1"
];
  home-manager.users.${username} = {
        imports = [
            ./home.nix
        ];
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
    python3
    nodejs_20
    rustup
    librespeed-cli
    exiv2
    (import ./win32yank.nix { inherit pkgs; })
  ];
nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
};

users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
};


    time.timeZone = "Europe/Berlin";

services.openssh.enable = true;
programs.ssh.startAgent = true;

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
    source-file /home/nixos/.dotfiles/tmux.conf
    '';
    };
    stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
        image = ./other/wallpaper.png;
        polarity = "dark";
    };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
