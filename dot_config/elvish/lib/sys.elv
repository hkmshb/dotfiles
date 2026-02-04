use os
use str

# get the host ip-address
fn host-ip {
  var ip-pattern = '([0-9]{1,3}\.){3}[0-9]{1,3}'
  put (ifconfig | grep -E $ip-pattern | grep -v 127.0.0.1 | awk '{ print $2}' | cut -f2 -d: | head -n1)
}

# run rbw get
fn rbw-get {|key|
  var res = (echo (rbw get --raw $key) | from-json)
  put [
    &usr=$res[data][username]
    &pwd=$res[data][password]
    &host=$res[fields][0][value]
  ]
}

fn docker-psql {|db user @sql|
  var data-dir = $E:PROJECTS/data/dump/
  mkdir -p $data-dir

  docker run --rm --name psql ^
      -v $E:PROJECTS/data/dump:/mnt ^
      -i alpine/psql ^
      -h (host-ip) ^
      -p 54320 ^
      -U $user ^
      -d $db -W ^
      -c $@sql
}

# load-ini read ini formatted config data from a file
fn load-ini {|@path|
  if (not (os:exists $@path)) {
    echo (styled 'error: file not found "'$@path'"' red)
    exit 1
  }

  var data = [&]
  var lines = [(
    str:split "\n" (slurp < $@path) |
    each {|x| if (!=s $x '') { put $x }} |
    each {|line|
      if (not (str:has-prefix $line '#')) {
        var pair = [(str:split '=' $line | each {|x| put (str:trim-space $x)})]
        set data[$pair[0]] = $pair[1]
      }
    }
  )]

  put $data
}
