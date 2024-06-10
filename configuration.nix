
{ config, lib, pkgs, ... }:

{
imports = [
  ./vpn.nix
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
  home-manager.users.nixos = {
        imports = [
            ./home.nix
        ];
    };

  boot.tmp.cleanOnBoot = true;
  environment.systemPackages = with pkgs; [
  git neovim
];
nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
};

services.openssh.enable = true;
environment.shellAliases = {
      flake-rebuild = "sudo nixos-rebuild switch --flake .#NixWsl";
    };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
