if status is-interactive
    zoxide init fish | source
    # use starship prompt
    starship init fish | source
    set -gx EDITOR nvim
end
