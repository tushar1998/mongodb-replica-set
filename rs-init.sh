#! /bin/bash
docker-compose up -d

sleep 10

docker exec -it mongo1 mongosh --eval "rs.initiate({                                                                                        
 _id: \"dbrs\",
 members: [
   {_id: 0, host: \"mongo1\"},
   {_id: 1, host: \"mongo2\"},
   {_id: 2, host: \"mongo3\"}
 ]
})"