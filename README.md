To make sure your `.bash_extras` configs are sourced please run

```sh
echo -e "\n# Load portable git-tracked settings\n[[ -f ~/.bash_extras ]] && . ~/.bash_extras" >> ~/.bashrc
```

If your `.bashrc` does not already source for `.bash_aliases` (Ubuntu and derivatives do, usually, but it depends), you can run a similar command

```sh
echo -e "\n# Load custom git-tracked aliases \n[[ -f ~/.bash_aliases ]] && . ~/.bash_extras" >> ~/.bash_aliases
```
