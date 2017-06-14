serverbox() {
  [[ "$#" -lt 2 ]] && {
    echo Fail. Usage: serverbox ip volume
    return
  }
  ip="$1"
  volume="$2"
  del_if_stopped nginx -d -P ${ip}:80:80 -v "${volume}:/usr/share/nginx/html/"
  
}
