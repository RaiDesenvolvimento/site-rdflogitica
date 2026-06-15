#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"
touch "$DIST_DIR/.nojekyll"

cp "$ROOT_DIR/RDF - Início (offline).html" "$DIST_DIR/Home.html"
cp "$ROOT_DIR/RDF - Início (offline).html" "$DIST_DIR/index.html"
cp "$ROOT_DIR/RDF - COMEX (offline).html" "$DIST_DIR/COMEX.html"
cp "$ROOT_DIR/RDF - Logística (offline).html" "$DIST_DIR/Logistica.html"
cp "$ROOT_DIR/RDF - Sobre (offline).html" "$DIST_DIR/Sobre.html"
cp "$ROOT_DIR/RDF - Contato (offline).html" "$DIST_DIR/Contato.html"

echo "Static site built at $DIST_DIR"
