# podman
# edit:add-var docker~ {|@a| podman $@a}


# aliases
edit:add-var cat~  {|@a| bat $@a}
edit:add-var cz~   {|@a| chezmoi $@a}
edit:add-var ls~   {|@a| lsd --icon=never --group-directories-first $@a}
edit:add-var vi~   {|@a| nvim $@a}

# docker aliases
edit:add-var d~    {|@a| docker $@a}
edit:add-var di~   {|@a| docker image $@a}
edit:add-var dv~   {|@a| docker volume $@a}
edit:add-var dc~   {|@a| docker compose $@a}
edit:add-var dcb~  {|@a| docker compose build $@a}

# git aliases
edit:add-var ga~       {|@a| git add $@a}
edit:add-var gb~       {|@a| git branch $@a}
edit:add-var gs~       {|@a| git status -sb $@a}
edit:add-var gc~       {|@a| git commit $@a}
edit:add-var gco~      {|@a| git checkout $@a}
edit:add-var gd~       {|@a| git diff $@a}
edit:add-var gds~      {|@a| git diff --staged $@a}
edit:add-var glo~      {|@a| git log --oneline --decorate $@a}
edit:add-var glog~     {|@a| git log --oneline --decorate --graph $@a}
edit:add-var gcdev~    { git checkout dev }
edit:add-var gcdev!~   { git checkout dev; git pull }
edit:add-var gcd~      { git checkout develop }
edit:add-var gcd!~     { git checkout develop; git pull }
edit:add-var gcm~      { git checkout main }
edit:add-var gcm!~     { git checkout main; git pull }
edit:add-var gcs~      { git checkout staging }
edit:add-var gcs!~     { git checkout staging; git pull }
edit:add-var gb-prune~ { git remote prune origin }

# git-bug
edit:add-var .gb~      {|@a| git-bug $@a}
edit:add-var .gbb~     {|@a| git-bug bridge $@a}

# jujutsu
edit:add-var jj.d~     {|@a| jj desc $@a}
edit:add-var jj.df~    {|@a| jj diff $@a}
edit:add-var jj.e~     {|@a| jj edit $@a}
edit:add-var jj.l~     {|@a| jj log -r 'all()' -n 10 $@a}
edit:add-var jj.ll~    {|@a| jj log -r 'all()' $@a}
edit:add-var jj.lb~    {|@a| jj log -r 'root()..@' $@a}
edit:add-var jj.n~     {|@a| jj new $@a}
edit:add-var jj.s~     {|@a| jj st $@a}
edit:add-var jj.~      {|@a| jj st $@a}
edit:add-var jj,~      {|@a| jj split $@a}
edit:add-var jj-~      {|@a| jj edit @- $@a}
edit:add-var jj+~      {|@a| jj edit @+ $@a}
edit:add-var jj.ig~    {|@a| jj file untrack $@a}

# hammerspoon
edit:add-var hs-alert~ { hs -A -c "notifyTaskCompleted()" }

