#!/bin/bash

set -x

DATA=/Users/paul/github/pd3c-explorations/data/neo4j/data
LOGS=/Users/paul/github/pd3c-explorations/data/neo4j/logs
USER=neo4j
PASSWORD=`cat .neo4j-password`

echo "============ credentials"
echo $USER
echo $PASSWORD


if [[ -z "$PASSWORD" ]]; then
   echo "ERROR: Password is not set. Create a password in a .neo4j-password file."
   exit 1
fi

docker run --name=john01 \
    --publish=7474:7474 --publish=7687:7687 \
    --volume=$DATA:/data \
    --volume=$LOGS:/logs \
    -d \
    --user=$USER \
    --env NEO4J_AUTH=neo4j/$PASSWORD \
    --env 'NEO4JLABS_PLUGINS=["apoc", "graph-algorithms"]' \
    --env NEO4J_dbms_security_procedures_unrestricted=apoc.\\\*,algo.\\\* \
    neo4j:3.5.12
