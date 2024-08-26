FROM registry.access.redhat.com/ubi9/ubi:9.4-1181@sha256:1ee4d8c50d14d9c9e9229d9a039d793fcbc9aa803806d194c957a397cf1d2b17
RUN dnf -y install iputils iproute ethtool pciutils
COPY l2discovery /usr/bin
USER 0
CMD ["/bin/sh", "-c", "/usr/bin/l2discovery"]
