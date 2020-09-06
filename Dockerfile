
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive 

# Install Dependecies
RUN apt-get update && \
    apt-get install -y flex && \
    apt-get install -y bison && \
    apt-get install -y gperf && \
    apt-get install -y build-essential && \
    apt-get install -y git && \
    apt-get install -y tcl8.5 tk8.5 tcl8.5-dev tk8.5-dev tcllib

# Install Iverilog
RUN apt-get install -y iverilog

# Install GTKWave
RUN apt-get install -y gtkwave

# Install Covered
RUN mkdir -p /share/covered
WORKDIR /share/covered
RUN git clone https://github.com/Manarabdelaty/verilog-covered \
    && cd verilog-covered \
    && ./configure \
    && make \
    && make install 

# Install Yosys
RUN apt-get install -y yosys

WORKDIR /
