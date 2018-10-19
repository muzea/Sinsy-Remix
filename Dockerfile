FROM debian:8-slim

USER root

ADD https://mirrors.163.com/.help/sources.list.jessie /

RUN mv /sources.list.jessie /etc/apt/sources.list

RUN apt update \
    && apt install -y git gcc make g++

RUN git clone https://github.com/muzea/Sinsy-Remix.git

RUN cd Sinsy-Remix && git checkout docker \
    && cd hts_engine_API \
    && chmod +x ./configure \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && chmod +x ./configure \
    && ./configure \
          --with-hts-engine-header-path=/Sinsy-Remix/hts_engine_API/include \
          --with-hts-engine-library-path=/Sinsy-Remix/hts_engine_API/lib \
    && make \
    && make install \
    && wget http://downloads.sourceforge.net/sinsy/hts_voice_nitech_jp_song070_f001-0.90.tar.gz \
    && tar -zxf http://downloads.sourceforge.net/sinsy/hts_voice_nitech_jp_song070_f001-0.90.tar.gz \
    && mv ./hts_voice_nitech_jp_song070_f001-0.90/nitech_jp_song070_f001.htsvoice /Sinsy-Remix

