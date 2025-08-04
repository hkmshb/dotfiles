use os
use path
use re
use str


var token = ""
try {
 set token = (rbw get github-token | sed -n 's/^classic=//p')
} catch {|| }

# Retrieves repo description from remote repository on GitHub
fn fetch-desc {|&owner='' &name=''|
  var variables = [&owner=$owner &name=$name]
  var query = (str:join ' ' [
    'query($owner: String!, $name: String!){'
    '  repository(owner: $owner, name: $name) {'
    '    name description url'
    '}}'
  ])

  var data = (put [&query=$query &variables=$variables] | to-json)
  var resp = (curl -sH "Authorization: bearer "$token ^
      -H "Content-Type: application/json" ^
      -X POST "https://api.github.com/graphql" ^
      -d $data
  )

  var t = (echo $resp | from-json)
  put $t[data][repository][description]
}

# Determines whether a directory is a git repository and returns map
# with metadata meta like repo name and owner
fn meta {|dir|
  var repo = (and (os:is-dir $dir) (os:is-dir $dir/.git))
  if (not $repo) {
    put [&ok=$false &dir=$nil &name=$nil &owner=$nil]
    return
  }

  var url = (git remote get-url origin 2>&-)
  var m = (re:find '.*[/:]([^/]+)/([^.]+)(\.git)?$' $url)
  put [
    &ok=$true
    &dir=$dir/.git
    &owner=$m[groups][1][text]
    &name=$m[groups][2][text]
  ]
}

fn branch { 
  var name = (git symbolic-ref head 2>&-)
  put (str:trim-prefix $name "refs/heads/")
}

# Reads a repo description from the .git/description file
fn desc {|dir &silent=$false|
  var repo = (meta $dir)
  if (not $repo[ok]) {
    if (not $silent) { echo (styled 'error:' red)' no repo found'}
    return
  }

  put (cat $repo[dir]/description)
}

# Sets a description for a repo in the .git/description file
fn set-desc {|dir msg &silent=$false|
  var repo = (meta $dir)
  if (not $repo[ok]) {
    if (not $silent) { echo (styled 'error:' red) 'no repo found' }
    return
  }

  echo $msg > $repo[dir]/description
}

# Sets a description for a repo from the remote origin repo
fn sync-desc {|dir &silent=$false|
  var repo = (meta $dir)
  if (not $repo[ok]) {
    if (not $silent) { echo (styled 'error:' red) 'no repo found'}
    return
  }

  var value = (fetch-desc &owner=$repo[owner] &name=$repo[name])
  set-desc $dir $value &silent=$silent
  echo (styled 'set:' green)' '$value
}

fn dirname {
  put (path:base $pwd)'/'
}

fn dirty {
  if (not ?(git status -s 2>&-)) {
    put ""
  } else {
    var lines = [(git status --porcelain)]
    if (== (count $lines) 0) {
      put "on "(styled (branch) green)
    } else {
      put "on "(styled (branch) red)
    }
  }
}

fn prompt {
  put "\nin "(styled (dirname) cyan)' '(dirty)"\n› "
}
