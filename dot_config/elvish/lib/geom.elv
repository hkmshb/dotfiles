use str

fn to-feat {|@items|
  if (!=s (kind-of $@items) 'list') {
    echo 'not list: '$@items
    set @items = [$@items]
  }

  var feats = []
  for item $@items {
    set feats = (conj $feats (echo '{
      "type": "Feature",
      "properties": {},
      "geometry": {
        "type": "Point",
        "coordinates": ['(str:join ',' $item)']
      }
    }' | from-json))
  }

  put $feats | to-json
}
