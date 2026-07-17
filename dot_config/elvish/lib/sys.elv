use flag
use os
use path
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

# scaffold a new project
fn scaffold {|name &lang=''|
  var target-langs = [&go=$true]
  if (not (has-key $target-langs $lang)) {
    var names = [(keys $target-langs)]
    echo (styled 'lang "'$lang'" unknown. expected any of: '(str:join ',' $names) red)
    exit 1
  }

  # ensure target folder/project doesn't already exist
  var proj-dir = (pwd)'/'$name
  if (os:exists $proj-dir) {
    echo (styled $proj-dir' already exist. operation aborted' yellow)
    return
  }
  
  # create project folder and necessary files
  echo (styled '... creating project scaffold' cyan)
  mkdir -p $proj-dir/{.log/pm,docs}
  touch $proj-dir/{.gitignore,.editorconfig,.justfile,README.md}

  # set default contents for editorconfig & justfile
  echo (styled '... add content:.editorconfig' cyan)
  echo (str:join "\n" [
    "root = true\n"
    "[*]"
    "charset = utf-8"
    "indent_size = 2"
    "indent_style = space"
    "trim_trailing_whitespace = true"
    "insert_final_newline = true"
  ]) > $proj-dir/.editorconfig

  echo (styled '... add content: .justfile' cyan)
  echo (str:join "\n" [
    "default:"
    "  just -l\n"
    "init:"
    "  echo 'pending...'\n"
  ]) > $proj-dir/.justfile

  # init git
  echo (styled '... initializing git' cyan)
  jj git init $proj-dir

  # scaffold for target language
  if (==s $lang "go") {
    # set gitignore for go
    echo (styled '... set .gitignore for go' cyan)
    gibo dump go > $proj-dir/.gitignore
 
    # create go module
    echo (styled '... creating go module' cyan)
    go mod init -C $name 'hazeltek.net/p/'$name
  }

  # done
  echo (styled 'scaffold created' cyan)
}

