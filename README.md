# docker-image-variation
template that could be used to create multiple image variants and push them to dockerhub.
# Build image
```sh
docker build -t alpine:variant2 ./variants/variant2/
docker run -it --rm alpine:variant2
```