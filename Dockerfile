FROM debian AS base

RUN apt update -y && apt upgrade -y && apt install build-essential -y && mkdir Project

COPY run.cpp /Project

WORKDIR /Project

RUN c++ run.cpp -o run && ./run

ENTRYPOINT ["bash"]
