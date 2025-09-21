#!/bin/bash
# env: GRAFANA_URL, GRAFANA_API_KEY, DASHBOARD_UID, OUTPUT_BUCKET

TIMESTAMP=$(date -u +"%Y-%m-%d")
OUTFILE="/tmp/grafana-${TIMESTAMP}.png"

# use render API (requires grafana-image-renderer or grafana >=7.1)
curl -s -H "Authorization: Bearer ${GRAFANA_API_KEY}" \
  "${GRAFANA_URL}/render/d-solo/${DASHBOARD_UID}/overview?panelId=2&width=1000&height=500&from=now-24h&to=now" \
  --output ${OUTFILE}

# upload to Azure blob (az cli) or S3
az storage blob upload --account-name ${REPORT_STORAGE_ACCOUNT} --container-name reports --file ${OUTFILE} --name "$(basename ${OUTFILE})" --auth-mode login

