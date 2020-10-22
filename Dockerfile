
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive 

# Install Dependecies
RUN apt-get update && \
    apt-get install -y flex && \
    apt-get install -y bison && \
    apt-get install -y gperf && \
    apt-get install -y build-essential && \
    apt-get install -y git && \
    apt-get install -y cmake && \
    apt-get install -y wget && \
    apt-get install -y swig && \
    apt-get install -y tcl tk tcl-dev tk-dev tcllib

# Install Magic Dependecies
RUN apt-get install -y csh libx11-dev libcairo2-dev libncurses-dev

# Install Iverilog
RUN apt-get install -y iverilog

# Install GTKWave
# RUN apt-get install -y gtkwave

# Install Covered
# RUN mkdir -p /share/covered
# WORKDIR /share/covered
# RUN git clone https://github.com/Manarabdelaty/verilog-covered \
#     && cd verilog-covered \
#     && ./configure \
#     && make \
#     && make install 

# Install Yosys
RUN apt-get install -y yosys

# Install OpenSTA
RUN git clone https://github.com/The-OpenROAD-Project/OpenSTA

WORKDIR OpenSTA

RUN git checkout 6deaf6d8fcabc884063941c3046eb8bdb80061b5

RUN mkdir /build
RUN mkdir build

WORKDIR build
RUN cmake -DCMAKE_INSTALL_PREFIX=/build -DCUDD=/usr/local ..

RUN make -j$(nproc)

RUN mkdir -p /build/bin/ && \
    cp ../app/sta /usr/bin

WORKDIR /

# Install Magic
RUN git clone https://github.com/RTimothyEdwards/magic.git

WORKDIR magic

# build
RUN ./configure && \
    make -j4 && \
    make install

# Install Sky130 PDK
RUN mkdir -p /pdk && \
    cd /pdk

WORKDIR /pdk
RUN git clone https://github.com/google/skywater-pdk.git && \
    cd skywater-pdk && \
    git submodule update --init libraries/sky130_fd_sc_hd/latest && \
    make sky130_fd_sc_hd

# Install Open-PDKs
RUN git clone https://github.com/RTimothyEdwards/open_pdks.git && \
    cd open_pdks && \
    git checkout 48db3e1a428ae16f5d4c86e0b7679656cf8afe3d && \
    ./configure --with-sky130-source=/pdk/skywater-pdk/libraries --with-sky130-local-path=/pdk

WORKDIR /
