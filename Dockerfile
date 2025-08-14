FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    ca-certificates curl nmap jq git python3 python3-venv python3-pip \
 && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir requests rapidfuzz packaging sentence-transformers

COPY wan-cve-audit.sh /usr/local/bin/wan-cve-audit.sh
RUN chmod +x /usr/local/bin/wan-cve-audit.sh

WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/wan-cve-audit.sh"]
