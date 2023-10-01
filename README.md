#### Run script
```sh
cd && if [ ! -e ".config/nvim/" ]; then mkdir ~/.config/nvim; fi
```


#### Clone git repo
<code>git clone https://github.com/Charobaca/nvim-config ~/.config/nvim</code> 


#### Install vim-plug
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

#### Install plugins
<code>nvim -c "PlugInstall"</code>
<code>nvim -c "CocInstall coc-json coc-python coc-snippets coc-vimlsp coc-tsserver coc-pairs coc-prettier coc-clangd coc-pyright coc-jedi"</code>


### Errors

#### E117: Unknown function: SemshiBufWipeout
<code>nvim -c "UpdateRemotePlugins"</code>


#### Congratulations!

# Coc-nvim

## Black Formatting
  "python.formatting.provider": "black",
  "python.formatting.blackPath": "~/.local/bin/black",
