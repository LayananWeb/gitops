# Sanitized GitOps Sample Repository

This repository is a sanitized public sample of a GitOps-oriented Kubernetes delivery structure.

It is published for portfolio, documentation, and interview discussion purposes only.

## Important Notice

This repository does not represent a live production source of truth.

The public version has been intentionally sanitized. Infrastructure identifiers, domains, cloud account references, secret paths, and other environment-specific details have been replaced with example values where appropriate.

No active credentials are intended to be stored in this repository.

## What This Repository Demonstrates

This sample is designed to show how a GitOps repository can be organized around:

- Argo CD for Git-to-cluster reconciliation
- Helm charts for reusable application packaging
- Environment-specific configuration under `environments/`
- External Secrets Operator patterns for secret synchronization
- Terraform stacks for selected infrastructure components
- Basic monitoring manifests using Prometheus and Grafana

## Repository Structure

```text
.
├── argocd/                   # Argo CD configuration and Application manifests
│   ├── project/
│   └── argocd-*.yaml
├── charts/                   # Reusable Helm charts per service
│   ├── lti/
│   ├── mas-presensi/
│   ├── redis/
│   └── sso/
├── environments/             # Environment-specific values and raw manifests
│   ├── lti/
│   ├── mas-presensi/
│   ├── monitoring/
│   ├── sso/
│   └── tools/
├── external-secrets/         # Secret store and IAM-related example configuration
└── teraform/                 # Terraform stacks for infrastructure provisioning examples
    ├── eks-aws/
    ├── rds-aws/
    └── s3-aws/
```

## Included Sample Workloads

The repository includes example delivery structures for:

- `sso`
- `lti`
- `mas-presensi`
- `redis`
- `monitoring`

Each workload is typically represented through:

- a reusable Helm chart in `charts/<application>`
- environment-specific values or manifests under `environments/<application>/<environment>`
- an Argo CD `Application` manifest under `argocd/project/applications/`

## Intended Use

This repository is suitable for:

- demonstrating GitOps repository layout in interviews
- discussing deployment structure and operational patterns
- sharing a sanitized example of Argo CD, Helm, External Secrets, and Terraform usage

This repository is not intended to be applied directly to any real environment without further review, reconfiguration, and secret management.

## Validation Examples

Example local validation commands:

Render the monitoring kustomization:

```bash
kubectl kustomize environments/monitoring/base
```

Render a Helm chart directly:

```bash
helm template dev-sso charts/sso -f environments/sso/dev/sso-values-dev.yaml
```

Render an environment that uses raw manifests:

```bash
kubectl kustomize environments/lti/dev
```

## Terraform Examples

Terraform examples are intentionally separated into standalone stacks under `teraform/`.

Available examples:

- `teraform/eks-aws`
- `teraform/rds-aws`
- `teraform/s3-aws`

These directories are included to demonstrate structure and separation of concerns, not to imply automatic provisioning from this repository.

## Public Repository Safety

The public contents of this repository have been sanitized for external sharing.

That sanitization includes, where applicable:

- replacing real domains with example domains
- replacing cloud account identifiers with placeholder values
- replacing secret references with sample values
- removing or redacting credentials from tracked files and published history

If this repository is ever reused as a starting point for a real deployment, all placeholders, identities, access policies, and secret-management flows should be reviewed and rebuilt for the target environment.
