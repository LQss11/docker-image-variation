#!/bin/bash

# This command will allow pipeline from running this script to prevent permission denied output
# git update-index --chmod=+x .\build-scripts\anonymous-docker-build.sh
for VARIANT in ./variants/*; do
    if [[ "$VARIANT" == *"Dockerfile"* ]]; then
        BASE=$(echo $VARIANT | cut -d "." -f3)
    else
        VARIANTS+=($(echo $VARIANT | cut -d "/" -f3))
    fi
done
echo "Building base images $BASE..."
docker build --pull --tag $BASE --file ./variants/Dockerfile.$BASE ./base-context
for VARIANT in ${VARIANTS[@]}; do
    #sed "s/base/$BASE/g" ./variants/$VARIANT/Dockerfile
    echo docker build . -t fifo -f <(sed "s/base/$BASE/g" ./variants/$VARIANT/Dockerfile) >test
    #echo "PUSHING $BASE-$VARIANT"
    #echo docker push $BASE-$VARIANT
done

# echo "Pushing base images..."
# echo "PUSHING lqss/jenkins:admin"
# docker push lqss/jenkins:admin
# echo "PUSHING lqss/jenkins:anonymous"
# docker push lqss/jenkins:anonymous
# echo "PUSHING lqss/jenkins:latest"
# docker image tag lqss/jenkins:admin lqss/jenkins:latest
# docker push lqss/jenkins:latest
