#!/bin/bash

###
# шардирование коллекции helloDoc
###

docker compose exec -T mongos1 mongosh <<EOF
sh.addShard( "shard1rs/mongo-shard1-1:27018,mongo-shard1-2:27018,mongo-shard1-3:27018")
sh.addShard( "shard2rs/mongo-shard2-1:27018,mongo-shard2-2:27018,mongo-shard2-3:27018")
EOF
