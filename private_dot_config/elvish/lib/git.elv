use path
use str

fn branch { 
  var name = (git symbolic-ref head 2>&-)
  put (str:trim-prefix $name "refs/heads/")
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

fn need-push {
}

fn prompt {
  put "\nin "(styled (dirname) cyan)' '(dirty)"\n› "
}
