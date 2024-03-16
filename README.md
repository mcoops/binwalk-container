# binwalk-container

Container with all extra tools installed using a minimal `alpine` base image.

As such there is currently one change required to allow `sasquatch` to build on `alpine`, which is appended to the end of the other patch file when compiling.

Additionally, for the older version of python, in this image on `alpine` there is no `lzop` so that much also be compiled and installed.

## Run

Mount the current working directory into the container at `/firmware` and run binwalk on the specified file. 

```sh
docker run -it --rm -v "$(pwd):/firmware" ghcr.io/mcoops/binwalk-container:latest <args> <file>
```
For example:

```sh
docker run -it --rm -v "$(pwd):/firmware" ghcr.io/mcoops/binwalk-container:latest -Me firmware.bin
```