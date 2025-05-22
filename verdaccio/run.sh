mkdir -p /share/verdaccio/storage

echo "✅ Starting Verdaccio with persistent storage..."
verdaccio --config /config.yaml --listen 0.0.0.0:4873