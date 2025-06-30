use path
use re
use str

## c completions

fn all-projects-dir {|@dir|
  var base-dir = $E:PROJECTS
  if (> (count $@dir) 0) {
    set base-dir = $base-dir/$@dir
  }
  put (ls $base-dir) | keep-if {|d| and (path:is-dir $base-dir/$d) (not (str:has-prefix $d _))} 
}

set edit:completion:arg-completer[c] = {|@args|
  var n = (count $args)
  if (== $n 2) {
      all-projects-dir
  } elif (>= $n 3) {
    cd $E:PROJECTS/$args[1]
    edit:return-line
    edit:clear
  }
}

