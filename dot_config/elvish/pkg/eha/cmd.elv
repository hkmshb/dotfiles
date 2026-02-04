#!/usr/bin/env elvish

use sys

var -tracks-download = [
  &help="download campaign tracks"
  &func={|params| # expected: schema campaign-id campaign-date
    var sql = "\\copy (
      SELECT id, team_name, campaign_date, campaign_id,
             ST_X(geom) as lng, ST_Y(geom) as lat,
             is_valid, accuracy, altitude, altitude_accuracy,
             heading, speed, timestamp, created_at
      FROM "$params[schema]".tracks
      WHERE campaign_id='"$params[campaign-id]"'
      ORDER BY created_at
    ) TO '/mnt/tracks.csv' WITH CSV HEADER
    "

    put (sys:docker-psql $params[db] $params[user] $sql)
  }
]

var -tracks-download-by-date = [
  &help="download campaign tracks by date"
  &func={|params| # expected: schema campaign-id campaign-date
    var sql = "\\copy (
      SELECT id, team_name, campaign_date, campaign_id,
             ST_X(geom) as lng, ST_Y(geom) as lat,
             is_valid, accuracy, altitude, altitude_accuracy,
             heading, speed, timestamp, created_at
      FROM "$params[schema]".tracks
      WHERE campaign_id='"$params[campaign-id]"'
        AND campaign_data='"$params[campaign-date]"'
      ORDER BY created_at
    ) TO '/mnt/tracks.csv' WITH CSV HEADER
    "

    put (sys:docker-psql $params[db] $params[user] $sql)
  }
]

var -tracks-summary = [
  &help="get tracks summary for a campaign (pf staging db)"
  &func={|tenant|
    var sql = "
      SELECT schema_name
      FROM public.tenants
      WHERE name='"$tenant"'
    "

    var schema = (echo (sys:docker-psql planfeld_staging postgres $sql) | awk '{ print $3 }')
    set sql = "
      SELECT campaign_date, campaign_id, COUNT(*)
      FROM "$schema".tracks
      GROUP BY campaign_date, campaign_id
      ORDER BY campaign_date, campaign_id
    "

    put (sys:docker-psql planfeld_staging postgres $sql)
  }
]

fn tracks-download {|@conf-path|
  # echo $-tracks-download[help]
  var conf = (sys:load-ini $@conf-path)
  $-tracks-download[func] $conf
}

