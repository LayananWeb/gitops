#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="${NAMESPACE:-dev-sso}"
SELECTOR="${SELECTOR:-app.kubernetes.io/name=sso,app.kubernetes.io/instance=dev-sso}"
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

echo "Running seed on pod: ${POD}"
kubectl -n "${NAMESPACE}" exec "${POD}" -- sh -lc '/app/sso-seed'
