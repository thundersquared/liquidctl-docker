FROM debian:stable-slim

COPY run.sh /run.sh

ARG DEBIAN_FRONTEND=noninteractive
ARG PIP_BREAK_SYSTEM_PACKAGES=1

RUN apt update && \
    apt install -y --no-install-recommends \
        python3 \
        python3-dev \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        python3-pkg-resources \
        python3-hidapi \
        python3-usb \
        i2c-tools \
        python3-smbus \
        libusb-1.0-0 \
        gcc \
        make \
        udev \
        libudev-dev && \
    pip3 install --no-cache-dir -U liquidctl && \
    apt-get remove --purge -y \
        python3-dev \
        python3-pip \
        gcc \
        make \
        libudev-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cache

CMD ["/run.sh"]
