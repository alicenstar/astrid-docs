# System Requirements

## Kubernetes (Helm Installation)

| Requirement | Minimum |
|-------------|---------|
| Kubernetes version | 1.27+ |
| CPU | 2 cores available |
| Memory | 4 Gi available |
| Storage class | Default storage class required |
| Helm | v3.12+ |

### Supported Distributions

- EKS, GKE, AKS, OKE
- k3s, RKE2, OpenShift OKD
- Kind (development only)

### Unsupported Distributions

- Docker Desktop
- MicroK8s

### Network Requirements

The cluster must have outbound access to:

| Endpoint | Purpose |
|----------|---------|
| `proxy.replicated.com` | Container image proxy |
| `replicated.app` | License validation and updates |
| Docker Hub (`index.docker.io`) | Base images (if not using proxy) |

{{#if entitlements.isAirgapSupported}}
For air-gapped installations, all required images are included in the air gap bundle.
{{/if}}

## Bare VM (Embedded Cluster Installation)

| Requirement | Minimum |
|-------------|---------|
| OS | Linux x86-64 with systemd |
| CPU | 2 cores |
| Memory | 2 GB (4 GB recommended) |
| Disk | 40 Gi at data directory, less than 80% full |
| Disk latency | Max P99 write latency of 10ms |
| Access | Root or sudo |

Embedded Cluster provisions Kubernetes automatically. No prior cluster is needed.
