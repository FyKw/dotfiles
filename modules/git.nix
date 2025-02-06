{ username, ... }:
{
home-manager.users.${username}.programs.git = {
    enable = true;
    userName  = "FynnKw";
    userEmail = "Fynn.Kwast@btc-ag.com";
    delta.enable = true;
    delta.options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
    };
    extraConfig = {
        push = {
            default = "current";
            autoSetupRemote = true;
        };
        merge = {
            conflictstyle = "diff3";
        };
        diff = {
            colorMoved = "default";
        };
    };
    aliases = {
        s = "status -s";
        st = "status";
        ci = "commit";
        ciam = "commit --amend --no-edit";
        co = "checkout";
        d = "diff";
        ds = "diff --staged";
        a = "add";
        aa = "add --all";
        lg = "log --pretty=oneline --decorate --graph --abbrev-commit -30";
    };
  };
  }
