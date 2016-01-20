FROM tukiyo3/rpi-ja
MAINTAINER hammmm <ham.lua@gmail.com>
RUN apt-get update
RUN apt-get install -y apt-utils curl
RUN apt-get install -y wget unzip
RUN apt-get install -y libjpeg8-dev make gcc
RUN ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h
RUN cd && wget https://github.com/jacksonliam/mjpg-streamer/archive/master.zip && unzip master.zip
RUN apt-get install -y cmake
RUN apt-get install -y g++
RUN cd ~/mjpg-streamer-master/mjpg-streamer-experimental && make clean application input_uvc.so output_http.so
CMD LD_LIBRARY_PATH=/root/mjpg-streamer-master/mjpg-streamer-experimental /root/mjpg-streamer-master/mjpg-streamer-experimental/mjpg_streamer -i "input_uvc.so -d /dev/video0" -o "output_http.so -w /root/mjpg-streamer-master/mjpg-streamer-experimental/www -p 8080"
