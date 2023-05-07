require 'cmp_zsh'.setup {
    zshrc = false,              -- Source the zshrc (adding all custom completions). default: false
    filetypes = { "zsh", "sh" } -- Filetypes to enable cmp_zsh source. default: {"*"}
}

-- Need to also add this to zshrc to capture completions (otherwise enabled zshrc sourcing, slow)
-- # completions
-- if [ -d $HOME/.zsh/comp ]; then
--    export FPATH="$HOME/.zsh/comp:$FPATH"
-- fi
