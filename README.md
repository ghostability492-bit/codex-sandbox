# WAN CPE CVE Audit

`wan-cve-audit.sh` performs WAN-facing CPE vulnerability auditing. It runs nmap scans,
queries Vulners, NVD (optional `NVD_API_KEY`), and MITRE CVE feeds, and writes findings
to per-run output directories (`out_<ip>_<timestamp>/`).

## Usage

```bash
./wan-cve-audit.sh <target> [options]

Options:
  --full-scan             Scan all TCP ports
  --ports LIST            Comma separated ports or ranges
  --no-nuclei             Skip Nuclei HTTP scanning
  --no-semantic           Disable semantic matching
  --timeout N             Network timeout in seconds
  --insecure              Allow insecure TLS for HTTP requests
  --simulate              Print commands and use fixtures
  --offline               Use fixtures instead of network
  --intensity PRESET      nmap intensity: fast|normal|aggr
  --nse PATTERN           Additional safe NSE scripts
  --remote user@host      Run inbound scan on remote host via SSH
  --public-ip IP          Public IP of this host when using --remote
```

## Docker

The recommended way to run the tool is via Docker:

```bash
make docker-run ARGS="--help"
```

For an offline simulation without Docker:

```bash
make dry-run ARGS='192.0.2.10 --simulate --offline'
```

Outputs are written under `out_<ip>_<timestamp>/`.

