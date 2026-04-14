# Helm Installation

{{#if entitlements.isHelmInstallEnabled}}

## Prerequisites

- A Kubernetes cluster meeting the [system requirements](pages/installation/requirements.md)
- Helm v3.12+ installed
- `kubectl` configured to access the cluster
- Your license ID: `{{ license.id }}`

## Step 1: Log In to the Replicated Registry

```bash
helm registry login registry.replicated.com \
  --username {{ customer.email }} \
  --password {{ license.id }}
```

## Step 2: Create the Image Pull Secret

```bash
kubectl create secret docker-registry astrid-registry \
  --docker-server=proxy.replicated.com \
  --docker-username={{ customer.email }} \
  --docker-password={{ license.id }}
```

## Step 3: Install {{ app.name }}

```bash
helm install astrid oci://registry.replicated.com/{{ app.slug }}/astrid \
  --set global.imagePullSecrets[0].name=astrid-registry
```

Wait for all pods to reach Running status:

```bash
kubectl get pods -w
```

## Step 4: Access the Application

```bash
kubectl port-forward svc/astrid 8080:8080
```

Open [http://localhost:8080](http://localhost:8080) in your browser.

## Configuration Options

See the [Astrid Helm Chart](pages/security/image-verification.md) reference for all configurable values, or review:

- [Database Configuration](pages/configuration/database.md) — embedded vs external PostgreSQL/Redis
- [Feature Toggles](pages/configuration/features.md) — workout streaks, OAuth

{{/if}}
