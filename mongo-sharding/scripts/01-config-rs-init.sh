#!/bin/bash

###
# Инициализизация replicaset'а конфигурации
###

docker compose exec -T mongo-cfgsrv1 mongosh --port 27019 <<EOF
rs.initiate(
  {
    _id: "configrs",
    configsvr: true,
    members: [
      { _id : 0, host : "mongo-cfgsrv1:27019" }
    ]
  }
)
EOF
