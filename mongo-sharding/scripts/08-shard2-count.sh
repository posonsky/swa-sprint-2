#!/bin/bash

###
# Проверка количества документов в shard2
###

docker compose exec -T mongo-shard2-1 mongosh --port 27018 <<EOF
use somedb
db.helloDoc.countDocuments()
EOF
