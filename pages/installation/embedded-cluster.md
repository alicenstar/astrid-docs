# Embedded Cluster Installation

{{#if entitlements.isEmbeddedClusterDownloadEnabled}}

Embedded Cluster installs {{ app.name }} on a bare Linux VM, provisioning Kubernetes automatically. No prior cluster setup is needed.

## Prerequisites

- A Linux VM meeting the [system requirements](pages/installation/requirements.md)
- Root or sudo access
- Your license file (download from this portal)

## Step 1: Download the Installer

Download the Embedded Cluster installer archive from the **Install** tab of this portal.

## Step 2: Extract and Run

```bash
tar xzf {{ app.slug }}-*.tgz
sudo ./{{ app.slug }} install --license license.yaml
```

Follow the interactive prompts to:
- Accept the end-user license agreement
- Set the installer admin password
- Configure networking (or accept defaults)

## Step 3: Access the Installer UI

The installer prints a URL (default: `http://<host-ip>:30080`). Open it in a browser and:

1. **Configure** — Set database mode (embedded/external), enable features
2. **Run Preflight Checks** — Verify system meets requirements
3. **Deploy** — Install the application
4. **Finish** — Access the running application

## Step 4: Verify

```bash
sudo ./{{ app.slug }} shell -c "kubectl get pods -A"
```

All pods should show `Running` or `Completed` status.

{{#if entitlements.isAirgapSupported}}
## Air-Gapped Installation

1. Download both the **application air gap bundle** and **Embedded Cluster air gap bundle** from this portal
2. Transfer both files and your license to the target VM
3. Run:

```bash
tar xzf {{ app.slug }}-*.tgz
sudo ./{{ app.slug }} install --license license.yaml --airgap {{ app.slug }}.airgap
```

All container images are included in the bundle. No outbound network access is required.
{{/if}}

{{/if}}
