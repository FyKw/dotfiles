{pkgs, ...}: {
    services.xserver.videoDrivers = ["nvidia"]; # IMMPORTANT

    hardware = {
        nvidia = {
            open = true; # if i want to use the open source drivers
        };

        graphics = {
            enable = true;
            enable32Bit = true;
        };
    };
}
