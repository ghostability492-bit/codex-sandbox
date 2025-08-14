# Static Analysis of `wan-cve-audit.sh`

## Issues Found
- **Dependency risk**: Original script installed packages without explicit user consent or version pinning, which could modify the host unexpectedly.
- **Input injection**: User supplied ports and targets were not validated rigorously, allowing option injection into `nmap` and other commands.
- **TLS weakness**: `curl -k` was used unconditionally, disabling certificate verification and enabling man‑in‑the‑middle attacks.
- **No offline mode**: The script required network connectivity for scanning and CVE lookups, making testing and analysis difficult in isolated environments.
- **Unbounded NSE usage**: Arbitrary `--script` arguments could trigger unsafe NSE scripts.

## Rationale for Changes
- Added strict CLI parsing, `validate_ports()` and `validate_target()` to prevent injection and malformed input.
- Introduced `--simulate`/`--offline` modes with fixtures to allow safe, repeatable dry‑runs without network access.
- Replaced unconditional `curl -k` with strict TLS by default and an explicit `--insecure` flag that logs a warning.
- Implemented intensity presets and an allow‑listed NSE pattern to limit nmap options to safe values.
- Centralised logging with `[STEP]`, `[OK]`, and `[WARN]` markers for clarity.

## Limitations
- Offline simulation uses static fixtures; it does not emulate all edge cases of real network environments.
- CVE matching is stubbed to read from fixture data; full integration with external databases would require network access and additional dependencies.
