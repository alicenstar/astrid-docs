# Support Bundles

Support bundles collect diagnostic information to help troubleshoot issues with your {{ app.name }} installation.

## What's Collected

- Application logs (astrid, postgresql, redis, replicated-sdk)
- Health endpoint status
- Deployment and StatefulSet status
- Kubernetes node readiness
- Storage class information
- Known failure pattern analysis

## Generating a Support Bundle

### From the Application UI

1. Log in to {{ app.name }}
2. Navigate to the **Support** page
3. Click **Generate Support Bundle**
4. The bundle is collected and uploaded to the Vendor Portal automatically

### From the Command Line (Embedded Cluster)

```bash
sudo ./{{ app.slug }} support-bundle -o support-bundle.tar.gz
```

Upload the resulting file through the **Support Bundles** tab of this portal.

## Analyzing Results

After upload, the bundle is automatically analyzed. Results include:

- **Pass** — Component is healthy
- **Warn** — Potential issue detected, review recommended
- **Fail** — Problem found with remediation steps

Review analyzer results in the **Support Bundles** tab of this portal or in the Vendor Portal.
