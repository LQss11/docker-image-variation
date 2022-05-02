#!/bin/bash
if [ -z "$REGISTRY" ]; then
REGISTRY="docker.io"
fi
if [ -z "$ACCOUNT" ]; then
ACCOUNT="lqss"
fi
for VARIANT in ./variants/*; do
    # Look for dockerfile inside variants directory 
    # To create main base image
    # Else assign variant names in variants variable
    if [[ "$VARIANT" == *"Dockerfile"* ]]; then
        BASE=$(echo $VARIANT | cut -d "." -f3)
        echo "Pushing base image $BASE..."
        docker image tag $BASE $REGISTRY/$ACCOUNT/$BASE:latest
        docker push $REGISTRY/$ACCOUNT/$BASE:latest
    else
        VARIANT=$(echo $VARIANT | cut -d "/" -f3)
        echo "Pushing variant image $VARIANT..."
        docker image tag $BASE:$VARIANT $REGISTRY/$ACCOUNT/$BASE:$VARIANT
        docker push $REGISTRY/$ACCOUNT/$BASE:$VARIANT
    fi
done