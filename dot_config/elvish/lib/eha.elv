# -----
#
# dependencies: rbw
# -----------------------------------------------------------------------------

use net
use os
use path
use rbw

var proj-dir = $E:PROJECTS/eha
var conf-dir  = $proj-dir/:cfg

# fetch gcp service-account credentials from secrets vault (bitwarden) and save
# to designated location for eha dev credentials
fn init-creds {
  var names = ["gcp-db-cred_dev.json" "gcp-db-cred_gdb.json"]

  # ensure base dir exists
  if (not (os:is-dir $conf-dir)) {
    os:mkdir-all $conf-dir
    echo (styled 'created' green) (styled $conf-dir" folder" yellow)
  }

  # save credential files that don't already exist
  for name $names {
    var cred-file = (path:join $conf-dir $name)
    if (not (os:exists $cred-file)) {
      rbw get $name > $cred-file 
      echo (styled 'created' green) (styled $name yellow)
    }
  }

  echo (styled "> done" green)
}

# run cloud-sql-proxy to connect to a database on gcp - pull credentials from 
# vault (bitwarden)
fn gcp-db-proxy {|&server='gdb' &port=54320|
  if (not (has-value ['dev' 'gdb'] $server)) {
    echo (styled 'error:' red) 'unknown server - '$server
    return
  }

  var v-key = 'gcp-db_'$server
  var v-val = (rbw:get $v-key)

  var gcs = $v-val[host]
  var cred-name = 'gcp-db-cred_'$server'.json'
  var cred-path = (path:join $conf-dir $cred-name)

  cloud-sql-proxy $gcs ^
               -c $cred-path ^
               -a (net:host-ip) ^
               -p $port
}

