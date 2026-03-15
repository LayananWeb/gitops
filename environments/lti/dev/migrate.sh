#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${NAMESPACE:-dev-lti}"
SELECTOR="${SELECTOR:-app=dev-lti}"
POD="${1:-}"

if ! command -v kubectl >/dev/null 2>&1; then
  echo "kubectl not found in PATH" >&2
  exit 1
fi

if [[ -z "${POD}" ]]; then
  POD="$(kubectl -n "${NAMESPACE}" get pods -l "${SELECTOR}" \
    --field-selector=status.phase=Running \
    -o jsonpath='{.items[0].metadata.name}')"
fi

if [[ -z "${POD}" ]]; then
  echo "No running pod found in namespace '${NAMESPACE}' with selector '${SELECTOR}'" >&2
  exit 1
fi

echo "Running migration on pod: ${POD}"
kubectl -n "${NAMESPACE}" exec "${POD}" -- sh -lc 'DATABASE_URL="postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}?sslmode=${DB_SSLMODE:-disable}"; /app/migrate -path /app/migrations -database "$DATABASE_URL" up'
