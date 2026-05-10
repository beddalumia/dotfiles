### beddalumia/dotfiles

This repository is meant to track my dotfiles across different machines. For this reason, it is organized
in different, hierarchical branches. Most basic, and universal stuff I want basically everywhere stays on
the `master` branch. COSMIC DE stuff, stays in the `cosmic` branch, unless it is machine specific. In that 
case it will go on a child of `cosmic`. Machine specific stuff is mostly related to different peripherals,
absence of a battery, need to be always reachable, multi-screen setups, etc. 

Machines that are on KDE or GNOME, will be based on `master` instead of `cosmic`, of course. Therein we 
will probably not track much config files, as both KDE and GNOME suck at them being plain text. We might
still want to track configs for tiling managers, like [PaperWM](https://github.com/paperwm/paperwm), 
[Karousel](https://github.com/peterfajdiga/karousel) and [niri](https://github.com/niri-wm/niri). 

On `master` for now we track some very standard dotfiles, but not the `.bashrc`, as different distros
can be very opinionated about that to put there, and generate a lot of conflicts. Hence the strategy 
is to keep the `.bashrc` _almost_ untouched, and put all the custom, git-tracked, configs into a 
`.bash_extras` file. 

To make sure your `.bash_extras` configs are sourced please run

```sh
echo -e "\n# Load portable git-tracked settings\n[[ -f ~/.bash_extras ]] && . ~/.bash_extras" >> ~/.bashrc
```

If your `.bashrc` does not already source for `.bash_aliases` (Ubuntu and derivatives do, usually, but it depends), you can run a similar command

```sh
echo -e "\n# Load custom git-tracked aliases \n[[ -f ~/.bash_aliases ]] && . ~/.bash_extras" >> ~/.bash_aliases
```

We are also tracking a cool `.inputrc` file, making the up/down arrow experience match matlab's perfection,
a simple, base-level `.gitconfig` and some other small things. We do not intend to track crazy stuff like
`.ssh`, or the `MATLAB` folder (for that we have the [Matverse](https://github.com/beddalumia/MATVERSE)).
We might add some simple, portable stuff from `.local/bin`, like bash screensavers, or OpenConnect scripts
for VPNs. Everything strives to be safe, rather than sorry. I.e. we want checks for existence of directories,
or to verify that something is installed before aliasing it, or worse invoking it.  

#### Bootstrapping on a new machine

First of all, run a temporary definition of the main alias (it will be set permanently after the bootstrap).

```sh
alias dots='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Then clone this repository as "bare", meant to track your `$HOME` as the work-tree (see alias above).

```sh
git clone --bare git@github.com:beddalumia/dotfiles.git $HOME/.dotfiles
```

Then configure your local git environment to ignore all the mess you surely have in your `$HOME`.

```sh
dots config --local status.showUntrackedFiles no
```

This will prevent the display of thousands of files when running `dots status`. If you want to add
something else to the git tracker, you need to know what exactly. The `cosmic` branch has some clever
aliases to help in this, as the `./config/cosmic/` directory can be quite messy, and unstable (COSMIC
is on alpha stafe). 

Finally you do the actual bootstrapping by checking out the relevant branch. 

```sh
dots checkout <branch-name>
```

If some of the files exist already git will complain (bare repos are more annoying about this).
You can force the bootstrap while backing up them safely by running:

```sh
mkdir -p .dotfiles-backup && dots checkout workstation-wien 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
```

We'd love to alias this, but before the bootstrapping you won't have it available anyway. At some point I
will define a `bootstrap.sh` script that you could just curl, but this is not the day.

