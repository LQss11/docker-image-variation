# docker-image-variation
template that could be used to create multiple image variants and push them to dockerhub.
# Build image
```sh
docker build -t alpine:variant2 ./variants/variant2/
docker run -it --rm alpine:variant2
```
# Build base & variants
A pipeline will handle running that script or you can simply run:
```sh
./build-scripts/build-variants.sh
```
then you can push the images by running:
```sh
REGISTRY=<registry-name> ACCOUNT=<account-name> ./build-scripts/push-variants.sh
```
>Make sure you are logged when trying to push by runnning `docker login`
> Also make sure to create the repository before pushing

Default values are if not set:
- REGISTRY=docker.io
- ACCOUNT=lqss 