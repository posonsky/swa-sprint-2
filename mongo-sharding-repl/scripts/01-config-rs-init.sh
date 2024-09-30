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
      { _id : 0, host : "mongo-cfgsrv1:27019" },
      { _id : 1, host : "mongo-cfgsrv2:27019" },
      { _id : 2, host : "mongo-cfgsrv3:27019" }
    ]
  }
)
EOF
