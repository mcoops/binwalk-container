FROM python:alpine3.11
LABEL org.opencontainers.image.source="https://github.com/mcoops/binwalk-container"

RUN apk add git wget mtd-utils gzip bzip2 tar openjdk11 p7zip cabextract squashfs-tools sleuthkit lzo-dev zlib-dev xz-dev bash alpine-sdk cmake libffi-dev

RUN adduser -u 1000 --disabled-password -s /sbin/nologin binwalk

RUN python3 -m pip install --upgrade pip

WORKDIR /tmp

COPY patch.txt .

RUN git clone https://github.com/RobertLarsen/sasquatch.git && cd sasquatch && cat /tmp/patch.txt >> patches/patch0.txt && ./build.sh 
RUN rm -rf sasquatch

RUN git clone https://github.com/sviehb/jefferson.git && cd jefferson && python3 -m pip install -r requirements.txt && python3 setup.py install
RUN rm -rf jefferson

RUN git clone https://github.com/devttys0/yaffshiv && cd yaffshiv && python3 setup.py install
RUN rm -rf yaffshiv

RUN wget https://www.lzop.org/download/lzop-1.04.tar.gz && tar xzvf lzop-1.04.tar.gz && cd lzop-1.04 && ./configure && make && make install
RUN rm -rf lzop-1.04 lzop-1.04.tar.gz patch.txt

RUN git clone https://github.com/ReFirmLabs/binwalk.git && cd binwalk && python3 setup.py install 
RUN rm -rf binwalk

RUN python3 -m pip install ubi_reader

RUN apk del alpine-sdk cmake lzo-dev zlib-dev xz-dev libffi-dev git wget

ENV DEBIAN_FRONTEND=teletype \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    PYTHONUTF8="1" \
    PYTHONHASHSEED="random"

WORKDIR /firmware

USER binwalk

ENTRYPOINT ["binwalk"]