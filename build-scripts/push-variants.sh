#!/bin/bash
for VARIANT in ./variants/*; do
    # Look for dockerfile inside variants directory 
    # To create main base image
    # Else assign variant names in variants variable
    if [[ "$VARIANT" == *"Dockerfile"* ]]; then
        BASE=$(echo $VARIANT | cut -d "." -f3)
        echo "Pushing base image $BASE..."
        docker image tag $BASE lqss/$BASE:latest
        docker push lqss/$BASE:latest
    else
        VARIANT=$(echo $VARIANT | cut -d "/" -f3)
        echo "Pushing variant image $VARIANT..."
        docker image tag $BASE:$VARIANT lqss/$BASE:$VARIANT
        docker push lqss/$BASE:$VARIANT
    fi
done