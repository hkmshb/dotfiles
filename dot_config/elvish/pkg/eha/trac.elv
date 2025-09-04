#!/usr/bin/env elvish

use net

fn exc {|@sql|
  docker run --rm --name psql ^
      -v /Users/abdulhakeem/projects/eha/_tmp:/mnt ^
      -i alpine/psql ^
      -h (net:host-ip) -p 54320 ^
      -U postgres -d planfeld_staging -W ^
      -c $@sql
}

fn cmd-download {|@dt|
  exc "\\copy (
    SELECT
        id
      , team_name
      , campaign_date
      , campaign_id
      , ST_X(geom) as lng
      , ST_Y(geom) as lat
      , is_valid
      , accuracy
      , altitude
      , altitude_accuracy
      , heading
      , speed
      , timestamp
      , created_at
    FROM tenant_f90c8df37f3c48018adab146ca86a360.tracks 
    WHERE campaign_id='63464867-6ac2-4e6e-be6d-f03cfbfff8b6' 
      AND campaign_date='"$@dt"'
    ORDER BY created_at
  ) TO '/mnt/sarmanan-mda_"$@dt"_total-0.csv' WITH CSV HEADER"
}

fn cmd-summary {
  exc "
    SELECT campaign_date, campaign_id, COUNT(*)
    FROM tenant_f90c8df37f3c48018adab146ca86a360.tracks
    GROUP BY campaign_date, campaign_id
    ORDER BY campaign_date, campaign_id
  "
}

fn print-help {
  echo ''
  echo 'usage: trac [commands] <options>'
  echo 'commands:'
  echo '  dload <date>'
  echo '  summary '
}


var cmd = ""
var opts = []

if (== (count $args) 0) {
  set cmd = "help"
} else {
  set cmd = $args[0]
  set opts = $args[1..]
}

if (or (==s $cmd "--help") (==s $cmd "help")) {
  print-help
} elif (==s $cmd "dload") {
  echo 'download ...'
  cmd-download $opts[0]
  echo 'done!'
} elif (==s $cmd "summary") {
  cmd-summary
} else {
  echo 'unknown command '$cmd
}
