# Upgrading {{ app.name }}

{{#if entitlements.isHelmInstallEnabled}}
## Helm Upgrade

When a new version is available, upgrade with:

```bash
helm upgrade astrid oci://registry.replicated.com/{{ app.slug }}/astrid \
  --set global.imagePullSecrets[0].name=astrid-registry \
  --reuse-values
```

Verify all pods are running:

```bash
kubectl get pods -w
```

The `--reuse-values` flag preserves your existing configuration. To change values during upgrade, pass additional `--set` flags or use a values file with `-f`.

### Zero-Downtime Upgrades

The application deployment uses a rolling update strategy by default. During upgrade:
- New pods are created before old pods are terminated
- The application remains accessible throughout the process
- Database data is preserved on persistent volumes
{{/if}}

{{#if entitlements.isEmbeddedClusterDownloadEnabled}}
## Embedded Cluster Upgrade

1. Download the new version archive from this portal
2. Transfer to the host VM
3. Extract and run:

```bash
tar xzf {{ app.slug }}-*.tgz
sudo ./{{ app.slug }} upgrade --license license.yaml
```

4. Log in to the installer UI with your admin password
5. Review and apply any configuration changes
6. Complete the upgrade

### Air-Gapped Upgrade

Download both the new application air gap bundle and Embedded Cluster air gap bundle, then:

```bash
tar xzf {{ app.slug }}-*.tgz
sudo ./{{ app.slug }} upgrade --license license.yaml --airgap {{ app.slug }}.airgap
```

### Data Persistence

Application data is stored on persistent volumes and survives upgrades. Auto-generated values (such as the embedded database password) are preserved across upgrades.
{{/if}}
