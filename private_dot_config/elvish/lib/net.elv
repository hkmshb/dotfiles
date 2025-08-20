
fn host-ip {
  var ip-pattern = '([0-9]{1,3}\.){3}[0-9]{1,3}'
  put (ifconfig | grep -E $ip-pattern | grep -v 127.0.0.1 | awk '{ print $2 }' | cut -f2 -d: | head -n1)
}

