#!/bin/bash

###
# Инициализизация replicaset'а shard'a 2
###

docker compose exec -T mongo-shard2-1 mongosh --port 27018 <<EOF
rs.initiate(
  {
    _id : "shard2rs",
    members: [
      { _id : 0, host : "mongo-shard2-1:27018" }
    ]
  }
)
EOF
