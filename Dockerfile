FROM gcc

RUN mkdir Project

COPY run.cpp /Project

WORKDIR /Project

RUN c++ run.cpp

ENTRYPOINT ["./a.out"]
