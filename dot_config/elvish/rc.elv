# source local '-' prefixed scripts for side effect
var pkg-dir = ~/.config/elvish/pkg
for dir [paths.elv completions.elv] {
  eval (slurp < $pkg-dir/$dir)
}

# NOTE: the following use directives are required to have modules available 
# within interactive terminals even if not used directly within this script
use gcp
use git
use net

# set prompt
# set edit:prompt = $git:prompt~

## activate tools
## ---------------

# active mise-en-place
var -m: = (ns [&])
eval (mise activate elvish | slurp) &ns=$-m: &on-end={|ns| set -m: = $ns }
-m:activate

# tool initializations
eval (direnv hook $E:SHELL | slurp)
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

