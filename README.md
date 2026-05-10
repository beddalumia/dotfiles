To make sure your `.bash_extras` configs are sourced please run

```sh
echo -e "\n# Load portable git-tracked settings\n[[ -f ~/.bash_extras ]] && . ~/.bash_extras" >> ~/.bashrc
```

If your `.bashrc` does not already source for `.bash_aliases` (Ubuntu and derivatives do, usually, but it depends), you can run a similar command

```sh
echo -e "\n# Load custom git-tracked aliases \n[[ -f ~/.bash_aliases ]] && . ~/.bash_extras" >> ~/.bash_aliases
```


## COSMIC-specific management

All COSMIC DE configurations live in plain-text files. Hence they are easy to track with git,
which is super-cool for us. Nevertheless:

1. We will be typically changing those configs via the COSMIC Settings GUI, not by directly
   editing the ugly text files. This is no hyprland madness.

2. Some of these configs are better to be left as machine dependent, or even completely untracked
   (different resolution on screen, different audio peripherals, different wallpapers, etc.).

3. COSMIC DE is still in alpha stage, so new files could pop up all the time, due to updates,
   or just setting a new preference, that was not existing before. 

Therefore we need to solve a nontrivial double problem: we want to track changes for only the
relevant (useful) files to sync, but we want to be able to see possible new relevant configs, 
when running `dots status` (i.e. after tweaking something in the GUI). 
As we are globally deactibating the display of untracked files for this repository (we don't 
want to see the whole damn $HOME), we will resort to a clever git hack.      
Everytime we setup a new COSMIC machine, we run:

```sh
dots add --intent-to-add ~/.config/cosmic/
```

which "pre-stages" all COSMIC config files, even if the repository defaults to not show any
untracked file. This option is inherently local, so don't forget to run this command after a
fresh install of the COSMIC dotfiles. If you want to be supersure to see new files, after a
GUI tweaking session, just run:

```sh
dots ls-files --others --exclude-standard -- .config/cosmic/
```

which will show all the not yet pre-staged paths in `.config/cosmic`.

To streamline the procedure we define a `cosmic-scan` alias (in `.bash_aliases`) so that one
can just run `dots status` to check for any change on already tracked COSMIC config files AND
run `cosmic-scan` to check for possible new COSMIC config files. These two commands need to be
invoked after any tweaking on the COSMIC Settings GUI (if one wants it to be permanent).  
