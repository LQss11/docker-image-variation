#!/bin/bash
for VARIANT in ./variants/*; do
    # Look for dockerfile inside variants directory 
    # To create main base image
    # Else assign variant names in variants variable
    if [[ "$VARIANT" == *"Dockerfile"* ]]; then
        BASE=$(echo $VARIANT | cut -d "." -f3)
        echo "Building base image $BASE..."
        docker build --pull --tag $BASE --file ./variants/Dockerfile.$BASE ./base-context        
    else
        VARIANT=$(echo $VARIANT | cut -d "/" -f3)
        echo "Building variant image $VARIANT..."
        sed -i "s/FROM base/FROM $BASE/g" ./variants/$VARIANT/Dockerfile 
        docker build -t $BASE:$VARIANT -f ./variants/$VARIANT/Dockerfile ./variants/$VARIANT
        sed -i "s/FROM $BASE/FROM base/g" ./variants/$VARIANT/Dockerfile 
    fi
done