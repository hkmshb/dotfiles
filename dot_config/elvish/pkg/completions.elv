use path
use str

## c completions

fn list-projects-dir {|@dir|
  var proj-dir = $E:PROJECTS
  var base-dir = $proj-dir

  var n = (count $dir)
  if (> $n 0) {
    set proj-dir = $base-dir/$dir[-1]
  }

  put (ls $proj-dir) ^
    | each {|d| if (== $n 0) { put $d'/' } else { put $dir[-1]$d'/' }} ^
    | keep-if {|d| and (path:is-dir $base-dir/$d) (not (str:has-prefix $d _))} 
}

set edit:completion:arg-completer[c] = {|@argv|
  var n = (count $argv)
  if (== $n 2) {
    if (str:has-suffix $argv[-1] /) {
      list-projects-dir $argv[-1]
    } else {
      list-projects-dir
    }
  }
}

