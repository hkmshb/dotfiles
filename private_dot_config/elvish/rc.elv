use git

# source local '-' prefixed scripts for side effect
var conf-dir = ~/.config/elvish
for dir [-paths.elv -comps.elv] {
  eval (slurp < $conf-dir/$dir)
}

# set prompt
set edit:prompt = $git:prompt~


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


# aliases
fn cz   {|@a| chezmoi $@a}
fn cat  {|@a| bat $@a}
fn vi   {|@a| nvim $@a}

# docker aliases
fn d    {|@a| docker $@a}
fn di   {|@a| docker image $@a}
fn dv   {|@a| docker volume $@a}
fn dc   {|@a| docker compose $@a}
fn dcb  {|@a| docker compose build $@a}

# git aliases
fn gb       {|@a| git branch $@a}
fn gs       {|@a| git status -sb $@a}
fn gc       {|@a| git commit $@a}
fn gco      {|@a| git checkout $@a}
fn gd       {|@a| git diff $@a}
fn gds      {|@a| git diff --staged $@a}
fn glo      {|@a| git log --oneline --decorate $@a}
fn glog     {|@a| git log --oneline --decorate --graph $@a}
fn gcdev    { git checkout dev }
fn gcdev!   { git checkout dev; git pull }
fn gcd      { git checkout develop }
fn gcd!     { git checkout develop; git pull }
fn gcm      { git checkout main }
fn gcm!     { git checkout main; git pull }
fn gb-prune { git remote prune origin }


## custom commands
## ---------------

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

