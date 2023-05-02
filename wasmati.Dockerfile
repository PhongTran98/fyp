FROM ubuntu:20.04
RUN apt-get update && apt-get install -y python3-dev 
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN apt-get install -y bison
RUN apt-get install -y flex
RUN apt-get install -y cmake
RUN apt-get -y install build-essential
RUN apt-get -y install libssl-dev
RUN apt-get -y install git
RUN apt-get -y install libzip-dev

WORKDIR /build
COPY ./wasmati/ /build
RUN mkdir -p build && cd build/ && cmake ../
RUN cmake --build /build/build --target wasmati

ENTRYPOINT [ "/build/build/wasmati" ]

