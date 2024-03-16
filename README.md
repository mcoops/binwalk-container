# binwalk-container

Container with all extra tools installed using a minimal `alpine` base image.

# RUN

Mount the current working directory into the container at `/firmware` and run binwalk on the specified file. 

```sh
docker run -it --rm -v "$(pwd):/firmware" ghcr.io/mcoops/binwalk-container:latest <args> <file>
```


```sh
docker run -it --rm -v "$(pwd):/firmware" ghcr.io/mcoops/binwalk-container:latest -Me firmware.bin
```