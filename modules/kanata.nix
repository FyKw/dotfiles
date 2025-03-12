{
    services.kanata = {
        enable = true;
        keyboards.default.config = ''
        (defsrc
            caps
        )

        (deflayer default
            esc
        )
            
        '';
    };
}
