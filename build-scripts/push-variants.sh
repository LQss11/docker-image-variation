#!/bin/bash
for VARIANT in ./variants/*; do
    # Look for dockerfile inside variants directory 
    # To create main base image
    # Else assign variant names in variants variable
    if [[ "$VARIANT" == *"Dockerfile"* ]]; then
        BASE=$(echo $VARIANT | cut -d "." -f3)
        echo "Pushing base image $BASE..."
        docker push lqss/$BASE:latest
    else
        VARIANT=$(echo $VARIANT | cut -d "/" -f3)
        echo "Pushing variant image $VARIANT..."
        docker push lqss/$BASE:$VARIANT
    fi
done