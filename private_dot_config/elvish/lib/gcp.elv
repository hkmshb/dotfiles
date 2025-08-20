use path
use net

var servers = [
  &dev='development-223016:europe-west1:ehealth-africa-dev'
  &gdb='production-228613:europe-west1:eha-gis'
]


fn cloudsql-proxy {|&server='gdb' &port=54320|
  if (not (has-key $servers $server)) {
    echo (styled 'error' red) 'unknown server: ' $server
    return
  }

  var gcs = $servers[$server]
  var cred-file = 'cloudsql-'$server'.json'
  var cred-path = (path:join $E:HOME 'projects/eha/.creds' $cred-file)

  cloud-sql-proxy $gcs ^
               -c $cred-path ^
               -a (net:host-ip) ^
               -p $port
}

