FROM registry.access.redhat.com/ubi9/ubi@sha256:9e6a89ab2a9224712391c77fab2ab01009e387aff42854826427aaf18b98b1ff
RUN dnf -y install iputils iproute ethtool pciutils; dnf clean all
RUN dnf -y remove python3-setuptools
COPY l2discovery-linux-amd64 /usr/bin
COPY l2discovery-linux-arm64 /usr/bin
RUN \
	if [ "$(uname -m)" = x86_64 ]; then \
        mv /usr/bin/l2discovery-linux-amd64 /usr/bin/l2discovery; \
	elif [ "$(uname -m)" = aarch64 ]; then \
        mv /usr/bin/l2discovery-linux-arm64 /usr/bin/l2discovery; \
	else \
		echo "CPU architecture is not supported." && exit 1; \
	fi
COPY l2discovery /usr/bin
USER 0
CMD ["/bin/sh", "-c", "/usr/bin/l2discovery"]
