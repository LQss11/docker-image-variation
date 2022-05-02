#!/bin/bash

# This command will allow pipeline from running this script to prevent permission denied output
# git update-index --chmod=+x .\build-scripts\anonymous-docker-build.sh
for VARIANT in ./variants/*; do
    # Look for dockerfile inside variants directory 
    # To create main base image
    # Else assign variant names in variants variable
    if [[ "$VARIANT" == *"Dockerfile"* ]]; then
        BASE=$(echo $VARIANT | cut -d "." -f3)
        echo "Building base images $BASE..."
        echo docker build --pull --tag $BASE --file ./variants/Dockerfile.$BASE ./base-context        
    else
        VARIANT=$(echo $VARIANT | cut -d "/" -f3)
        #echo sub $VARIANT
        sed -i "s/FROM base/FROM $BASE/g" ./variants/$VARIANT/Dockerfile 
        sleep 3
        sed -i "s/FROM $BASE/FROM base/g" ./variants/$VARIANT/Dockerfile 
        #docker build . -t fifo -f <(sed "s/base/$BASE/g" ./variants/$VARIANT/Dockerfile) #>test
    fi
done

# for VAR in $VARIANTS; do
#     #echo $VAR
#     #sed "s/base/$BASE/g" ./variants/$VARIANT/Dockerfile
#     #echo docker build . -t fifo -f <(sed "s/base/$BASE/g" ./variants/$VAR/Dockerfile) >test
#     #echo "PUSHING $BASE-$VARIANT"
#     #echo docker push $BASE-$VARIANT
# done

# echo "Pushing base images..."
# echo "PUSHING lqss/jenkins:admin"
# docker push lqss/jenkins:admin
# echo "PUSHING lqss/jenkins:anonymous"
# docker push lqss/jenkins:anonymous
# echo "PUSHING lqss/jenkins:latest"
# docker image tag lqss/jenkins:admin lqss/jenkins:latest
# docker push lqss/jenkins:latest
