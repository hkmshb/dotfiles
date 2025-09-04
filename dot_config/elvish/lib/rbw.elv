fn get {|key|
  var res = (echo (rbw get --raw $key) | from-json)
  put [
    &usr=$res[data][username]
    &pwd=$res[data][password]
    &host=$res[fields][0][value]
  ]
}
