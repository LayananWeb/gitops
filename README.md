# MBU Group GitOps Repository

This repository serves as the source of truth for Kubernetes-based application delivery using a GitOps operating model.

The platform stack in this repository is centered on:

- Argo CD for continuous synchronization from Git to Kubernetes
- Helm charts for reusable application packaging
- Environment-specific configuration under `environments/`
- External Secrets Operator for secret synchronization from AWS Secrets Manager
- Terraform stacks for selected infrastructure components

## Repository Purpose

This repository is intended to:

- Maintain deployment definitions in version control
- Separate reusable templates from environment-specific configuration
- Standardize promotion flows across development and production environments
- Keep infrastructure and application delivery configuration auditable and reproducible

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
├── external-secrets/         # ClusterSecretStore and IAM-related configuration
└── teraform/                 # Terraform stacks for infrastructure provisioning
    ├── eks-aws/
    ├── s3-aws/
    └── rds-aws/
```

## Managed Applications

The following workloads are currently represented in this repository:

- `sso`
- `lti`
- `mas-presensi`
- `redis`
- `monitoring` (Prometheus and Grafana baseline manifests)

Each application is typically defined through:

- a reusable Helm chart in `charts/<application>`
- environment-specific values or manifests under `environments/<application>/<environment>`
- an Argo CD `Application` manifest under `argocd/project/applications/`

## GitOps Delivery Model

The expected workflow is as follows:

1. Update Helm chart templates, values files, or environment manifests.
2. Open a merge request for review.
3. Merge approved changes into the tracked branch.
4. Allow Argo CD to detect drift and reconcile the target cluster.
5. If `ExternalSecret` resources are present, allow External Secrets Operator to synchronize the referenced values from AWS Secrets Manager.

## Infrastructure Prerequisites

Before this repository can be reconciled successfully, the target platform should provide:

- a running Kubernetes cluster
- a functioning Argo CD installation
- External Secrets Operator
- a configured `ClusterSecretStore` for AWS Secrets Manager access
- AWS IAM roles and policies that permit secret retrieval
- the expected secret keys in AWS Secrets Manager

Relevant references in this repository:

- [argocd-values.yaml](/Users/withyou/Documents/gitopss/argocd/argocd-values.yaml)
- [gitops-apps.yaml](/Users/withyou/Documents/gitopss/argocd/project/applications/gitops-apps.yaml)
- [clustersecretstore-aws-secretsmanager.yaml](/Users/withyou/Documents/gitopss/external-secrets/clustersecretstore-aws-secretsmanager.yaml)
- [externalsecret-sso-env.yaml](/Users/withyou/Documents/gitopss/environments/sso/prod/external-secrets/externalsecret-sso-env.yaml)

## Environment Configuration Model

Environment configuration is stored separately from reusable chart templates.

Typical examples:

- Helm values:
  - [lti-values-dev.yaml](/Users/withyou/Documents/gitopss/environments/lti/dev/lti-values-dev.yaml)
  - [sso-values-prod.yaml](/Users/withyou/Documents/gitopss/environments/sso/prod/sso-values-prod.yaml)
- External secrets:
  - [externalsecret.yaml](/Users/withyou/Documents/gitopss/environments/lti/prod/external-secrets/externalsecret.yaml)
  - [externalsecret.yaml](/Users/withyou/Documents/gitopss/environments/mas-presensi/dev/external-secrets/externalsecret.yaml)
- Monitoring manifests:
  - [kustomization.yaml](/Users/withyou/Documents/gitopss/environments/monitoring/base/kustomization.yaml)

This structure keeps deployment logic reusable while allowing each environment to define image tags, secrets, ingress rules, and scaling independently.

## Validation Before Merge

Recommended local validation commands:

Render the monitoring kustomization:

```bash
kubectl kustomize environments/monitoring/base
```

Render a Helm chart directly:

```bash
helm template dev-sso charts/sso -f environments/sso/dev/sso-values-dev.yaml
```

Render an application environment that uses raw manifests:

```bash
kubectl kustomize environments/lti/dev
```

## Terraform Stacks

Infrastructure code is intentionally separated into standalone Terraform stacks under `teraform/`.

Available stacks:

- [teraform/eks-aws](/Users/withyou/Documents/gitopss/teraform/eks-aws)
- [teraform/s3-aws](/Users/withyou/Documents/gitopss/teraform/s3-aws)
- [teraform/main.tf](/Users/withyou/Documents/gitopss/teraform/main.tf) for the existing root-level stack

These stacks are maintained independently so that infrastructure state does not become coupled across unrelated resources.

## Operational Notes

- Argo CD applications are stored under [argocd/project/applications](/Users/withyou/Documents/gitopss/argocd/project/applications).
- Monitoring currently provides a minimal baseline deployment of Prometheus and Grafana intended for initial rollout and validation.
- Grafana credentials in the current monitoring baseline should be replaced with externally managed secrets before production use.
- Terraform files have been added to the repository, but no Terraform execution is performed from this repository automatically.
