use flag
use str

fn -check-db  { echo 'checking db...' }
fn -create-db { echo 'creating db...' }
fn -show-help {
  echo """
usage: entrypoint.elv command [-dev]

commands:
  check-db        : check database
  create-db       : create database
"""
}


fn f {|cmd &dev=$true|
  var registry = [
    &check-db=$-check-db~
    &create-db=$-create-db~
  ]

  if (has-key $registry $cmd) {
    $registry[$cmd]
  } else {
    -show-help
    exit 1
  }
}

flag:call $f~ $args &on-parse-error={|_| 
  -show-help
  exit 1 
}
