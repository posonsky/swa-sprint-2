#!/bin/bash

###
# Инициализизация replicaset'а shard'a 1
###

docker compose exec -T mongo-shard1-1 mongosh --port 27018 <<EOF
rs.initiate(
  {
    _id : "shard1rs",
    members: [
      { _id : 0, host : "mongo-shard1-1:27018" },
      { _id : 1, host : "mongo-shard1-2:27018" },
      { _id : 2, host : "mongo-shard1-3:27018" }
    ]
  }
)
EOF
