#!/usr/bin/env elvish

use flag
use net
use os
use path
use str

# constants
var dir-data = $E:PROJECTS/bin/data

if (not (os:exists $dir-data)) {
  os:mkdir-all $dir-data
  echo (styled 'creating dir '$dir-data blue)
}

# read secrets file
fn load-dict {|@path|
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

# variables
var cmd = "help"
var opt = []
var cfg = (load-dict ./.secrets)

fn tool-psql {|@sql|
  docker run --rm --name psql@eha ^
    -v ($dir-data):/mnt ^
    -i alpine/psql ^
    -h (net:host-ip) -p 54320 ^
    -U postgres ^
    -d planfeld_staging ^
    -W -c $@sql
}

var cmd-trac-download = [
  &help="download campaign tracks (pf staging db)"
  &sql="
    SELECT id, team_name, campaign_date, campaign_id,
           ST_X(geom) as lng, ST_Y(geom) as lat,
           is_valid, accuracy, altitude, altitude_accuracy,
           heading, speed, timestamp, created_at
    FROM ...
    WHERE campaign_id=...
      AND campaign_data='""'
    ORDER BY created_at
  "
  &func={|campaign-id campaign-date|
    cmd-trac-psql 
  }
]

var cmd-trac-summary = [
  &help="get tracks summary for a campaign (pf staging db)"
  &sql="
    SELECT campaign_date, campaign_id, COUNT(*)
    FROM $tenant_id.tracks
    GROUP BY campaign_date, campaign_id
    ORDER BY campaign_date, campaign_id
  "
  &func={|@campaign-id|

  }
]
