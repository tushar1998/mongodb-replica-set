# Mongo DB Replica Set Steps

### Create Network

`docker network create mongoCluster`

### Start Mongo 1

```bash
docker run -d -p 27017:27017 --name mongo1 --network mongoCluster mongo:latest mongod --replSet myReplicaSet --bind_ip localhost,mongo1
```

### Start Mongo 2

```bash
docker run -d -p 27018:27017 --name mongo2 --network mongoCluster mongo:latest mongod --replSet myReplicaSet --bind_ip localhost,mongo2
```

### Start Mongo 3

```bash
docker run -d -p 27019:27017 --name mongo3 --network mongoCluster mongo:latest mongod --replSet myReplicaSet --bind_ip localhost,mongo3     
```

### Configure Mongo Replica Set
```bash
docker exec -it mongo1 mongosh --eval "rs.initiate({                                                                                        
 _id: \"dbrs\",
 members: [
   {_id: 0, host: \"mongo1\"},
   {_id: 1, host: \"mongo2\"},
   {_id: 2, host: \"mongo3\"}
 ]
})"
```

### Check Status
```bash
docker exec -it mongo1 mongosh --eval "rs.status()" 
```

### Connect to MongoDB with Compass
mongo://localhost:27017/<db-name>?replicaSet=<replSet>