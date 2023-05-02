FROM ubuntu:20.04

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update 
RUN apt-get install -y bison 
RUN apt-get install -y build-essential 
RUN apt-get install -y clang
RUN apt-get install -y cmake 
RUN apt-get install -y doxygen
RUN apt-get install -y flex
RUN apt-get install -y g++
RUN apt-get install -y git
RUN apt-get install -y libffi-dev
RUN apt-get install -y libncurses5-dev
RUN apt-get install -y libsqlite3-dev
RUN apt-get install -y make
RUN apt-get install -y mcpp
RUN apt-get install -y python
RUN apt-get install -y sqlite
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y git

RUN git clone https://github.com/souffle-lang/souffle.git
WORKDIR /souffle
RUN cmake -S . -B build -DSOUFFLE_DOMAIN_64BIT=ON
RUN cmake --build build

ENTRYPOINT [ "/souffle/build/src/souffle" ]

