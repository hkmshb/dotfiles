#!/usr/bin/env elvish

use it

var tracks-download = [
  &help="download campaign tracks (pf staging db)"
  &func={|schema campaign-id campaign-date|
    var sql = "
      SELECT id, team_name, campaign_date, campaign_id,
             ST_X(geom) as lng, ST_Y(geom) as lat,
             is_valid, accuracy, altitude, altitude_accuracy,
             heading, speed, timestamp, created_at
      FROM "$schema".tracks
      WHERE campaign_id='"$campaign-id"'
        AND campaign_data='"$campaign-date"'
      ORDER BY created_at
    "

    echo $sql
  }
]

var tracks-summary = [
  &help="get tracks summary for a campaign (pf staging db)"
  &func={|tenant|
    var sql = "
      SELECT schema_name
      FROM public.tenants
      WHERE name='"$tenant"'
    "

    var schema = (echo (it:exc-psql planfeld_staging postgres $sql) | awk '{ print $3 }')
    set sql = "
      SELECT campaign_date, campaign_id, COUNT(*)
      FROM "$schema".tracks
      GROUP BY campaign_date, campaign_id
      ORDER BY campaign_date, campaign_id
    "

    put (it:exc-psql planfeld_staging postgres $sql)
  }
]
