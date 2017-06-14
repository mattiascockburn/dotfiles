del_if_stopped() {
  container=$1
  shift
  docker ps -aq -f status=exited -f name=$container | xargs docker rm &>/dev/null
}

docker_clean() {
  docker ps -qa -f status=exited | xargs docker rm
  docker rmi $(docker images -q --filter "dangling=true")
}

# https://github.com/docker/docker/issues/20399
docker_imagelayers() {
  [[ "$#" -lt 1 ]] && {
    echo You need to supply an image tag/id
    return
  }
  docker images -q $1 | docker inspect --format "{{range .RootFS.Layers}}{{.}} {end}}" | sort -u
}

osc() {
  ID=$(id -u)
  IMAGE=osc:latest
  # we need to escape ':'
  BUILD_DIR="$(pwd | sed -e 's|:|\\:|')"

  docker run -t -i --rm \
    --volume "${HOME}/.oscrc":/home/build/.oscrc \
    --volume "$BUILD_DIR":/build \
    --env ID=$ID \
    --env "PARAMS=$*" \
    "$IMAGE" \
    bash -c "/entrypoint.sh"
}

dnsmasq() {
  IMAGE=andyshinn/dnsmasq:2.76
  del_if_stopped dnsmasq 
  docker run -d --name dnsmasq -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN $IMAGE $@
}


nginx() {
  IMAGE=nginx:latest
  VOLUME=${1:-$(pwd)}
  PROFILE=${2:-fileserver}
  del_if_stopped nginx
  docker run --name nginx \
    -p 80:80 \
    -v "${HOME}/docker/nginx/${PROFILE}.conf":/etc/nginx/conf.d/custom.conf \
    -v "$VOLUME":/usr/share/nginx/html:ro \
    -d nginx
}

dockerlint() {
  IMAGE=redcoolbeans/dockerlint
  docker run -it --rm -v "$PWD/Dockerfile":/Dockerfile:ro $IMAGE
}
