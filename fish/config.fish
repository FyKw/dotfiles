if status is-interactive
    zoxide init fish | source
    set -U fish_greeting "Moin"
    # use starship prompt
    starship init fish | source
    set -gx EDITOR nvim
end
