function docker_kill --description "Stop and then remove all running docker containers"
    docker stop (docker ps -a -q)
    docker rm (docker ps -a -q)
end
