{pkgs, ...}: {

    hardware = {
        nvidia = {
            open = false; # if i want to use the open source drivers

        };

        graphics = {
            enable = true;
            enable32Bit = true;
        };
    };
}
