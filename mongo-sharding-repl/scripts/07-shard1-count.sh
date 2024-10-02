#!/bin/bash

###
# Проверка количества документов в shard1
###

docker compose exec -T mongo-shard1-1 mongosh --port 27018 <<EOF
use somedb
db.helloDoc.countDocuments()
EOF
