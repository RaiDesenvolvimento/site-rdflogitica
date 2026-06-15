#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
SITE_DIR="${SITE_DIR:-/var/www/siteRdf}"
SERVICE_NAME="${SERVICE_NAME:-siterdf}"
SERVICE_USER="${SERVICE_USER:-$(id -un)}"
PORT="${PORT:-8000}"
HOST="${HOST:-0.0.0.0}"
PYTHON_BIN="$(command -v python3)"
SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"
TMP_SERVICE="/tmp/${SERVICE_NAME}.service"

if [[ ! -f "$DIST_DIR/index.html" ]]; then
  echo "dist/index.html not found. Run scripts/build-static.sh first." >&2
  exit 1
fi

if ! command -v systemctl >/dev/null 2>&1; then
  echo "systemctl not found. This deploy script requires systemd." >&2
  exit 1
fi

sudo mkdir -p "$SITE_DIR"
sudo cp -a "$DIST_DIR/." "$SITE_DIR/"
sudo chown -R "$SERVICE_USER:$SERVICE_USER" "$SITE_DIR"

cat > "$TMP_SERVICE" <<EOF
[Unit]
Description=RDF static site
After=network.target

[Service]
Type=simple
User=$SERVICE_USER
WorkingDirectory=$SITE_DIR
ExecStart=$PYTHON_BIN -m http.server $PORT --bind $HOST --directory $SITE_DIR
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

sudo install -m 0644 "$TMP_SERVICE" "$SERVICE_FILE"
rm -f "$TMP_SERVICE"

sudo systemctl daemon-reload
sudo systemctl enable "$SERVICE_NAME"
sudo systemctl restart "$SERVICE_NAME"
sudo systemctl --no-pager --full status "$SERVICE_NAME"
