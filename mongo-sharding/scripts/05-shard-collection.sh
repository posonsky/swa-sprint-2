#!/bin/bash

###
# шардирование коллекции helloDoc
###

docker compose exec -T mongos1 mongosh <<EOF
sh.shardCollection("somedb.helloDoc", { age : "hashed" } )
EOF
