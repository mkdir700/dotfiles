if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

starship init fish | source

export PATH="$PATH:/Users/mark/.bin"
export $(cat ~/.env | xargs)
