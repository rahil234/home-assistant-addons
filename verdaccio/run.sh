#!/bin/bash

CONFIG_FILE="/config.yaml"

echo "✅ Generating dynamic config.yaml..."

cat <<EOF > "$CONFIG_FILE"
storage: "${STORAGE_PATH}"

auth:
  htpasswd:
    file: "${HTPASSWD_FILE}"
    max_users: ${MAX_USERS}

uplinks:
  npmjs:
    url: "${UPLINK_URL}"

packages:
  "@*/*":
    access: \$all
    publish: \$authenticated
    proxy: npmjs

  "**":
    access: \$all
    publish: \$authenticated
    proxy: npmjs
EOF

if [ -n "${CUSTOM_PACKAGES}" ]; then
  echo "" >> "$CONFIG_FILE"
  echo "# Custom packages" >> "$CONFIG_FILE"
  echo "${CUSTOM_PACKAGES}" >> "$CONFIG_FILE"
fi

cat <<EOF >> "$CONFIG_FILE"

middlewares:
  audit:
    enabled: true

log:
  - type: stdout
    format: ${LOG_FORMAT}
    level: ${LOG_LEVEL}

web:
  enable: true
  title: "${WEB_TITLE}"
  url_prefix: "${WEB_URL_PREFIX}"

server:
  base: "${SERVER_BASE}"
EOF

echo "✅ Starting Verdaccio..."
verdaccio --config "$CONFIG_FILE"