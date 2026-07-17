# source local '-' prefixed scripts for side effect
var pkg-dir = ~/.config/elvish/pkg
for dir [envs.elv completions.elv] {
  eval (slurp < $pkg-dir/$dir)
}

# NOTE: the following use directives are required to have modules available 
# within interactive terminals even if not used directly within this script
#
# DO NOT REARRANGE
use path

use git
use re
use sys
use eha


## ghostty integration 
## -------------------

# set titlebar with these
fn update-title { printf "\e]2;%s\a" (path:base $pwd) }
set after-chdir = (conj $after-chdir {|_| update-title })
update-title

# load ghostty shell integration (cwd reporting for tab/split inheritance,
# prompt marks, cursor shape, sudo terminfo)
if (has-env GHOSTTY_RESOURCES_DIR) {
  eval (slurp < $E:GHOSTTY_RESOURCES_DIR/shell-integration/elvish/lib/ghostty-integration.elv)
}

# lua ------------
# Safely set LUA_INIT with proper Elvish single-quote string escaping
# set E:LUA_INIT = 'package.path = package.path .. '';/Users/abdulhakeem/.local/share/mise/installs/lua/5.1/share/lua/5.1/?.lua;/Users/abdulhakeem/.local/share/mise/installs/lua/5.1/share/lua/5.1/?/init.lua'''

## activate tools
## ---------------

## active mise-en-place
#var -m: = (ns [&])
#eval (mise activate elvish | slurp) &ns=$-m: &on-end={|ns| set -m: = $ns }
#-m:activate

set paths = [~/.local/share/mise/shims $@paths]

# tool initializations
eval (direnv hook elvish | slurp)
eval (zoxide init elvish | slurp)
eval (starship init elvish)

## expose aliases
## --------------
use ./pkg/aliases

# c command with completion to change into sub-directories in the
# projects directory
fn c {|@dir|
  var proj-dir = $E:PROJECTS
  var n = (count $dir)

  if (== $n 0) {
    cd $proj-dir
  } else {
    cd $proj-dir/$dir[-1]
  }
}

# mv-each $item - performs rename action with details in $item when
# a list `mv $item[0] $item[1]`; map `mv $item[src] $item[dst]`
fn mv-each {
  each {|item|
    if (==s (kind-of $item) 'list') {
      mv $item[0] $item[1]
    } elif (==s (kind-of $item) 'map') {
      mv $item[src] $item[dst]
    }
  }
}

# for-each $cb - calls $cb on each value input and returns list with
# original text and resulting text
fn for-each {|cb|
  each {|item|
    if (==s (kind-of $item) 'string') {
      var result = ($cb $item)
      put [$item $result]
    } else {
      var result = ($cb $item[1])
      put [$item[0] $result]
    }
  }
}

fn replace-each {|@patterns|
  for-each {|item|
    var src = $item
    for p $@patterns {
      set src = (put (re:replace $p[0] $p[1] $src))
    }

    put $src
  }
}


# load completion modules from zzamboni/elvish-completions
use github.com/zzamboni/elvish-completions/builtins
use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/ssh

