# Welcome to {{ app.name }}

{{ app.name }} is a fitness and nutrition tracker that helps users manage calorie plans, log daily meals, track workouts, and monitor body metrics with trend analysis.

## What's Included

- **{{ app.name }} Application** — Go backend with HTMX frontend
- **PostgreSQL 16** — Primary data store (embedded or bring-your-own)
- **Redis 7** — Session cache (embedded or bring-your-own)
- **Replicated SDK** — License management, update checks, and support bundle collection

## Quick Links

{{#if entitlements.isHelmInstallEnabled}}
- [Helm Installation](pages/installation/helm.md) — Deploy to an existing Kubernetes cluster
{{/if}}
{{#if entitlements.isEmbeddedClusterDownloadEnabled}}
- [Embedded Cluster Installation](pages/installation/embedded-cluster.md) — Deploy to a bare Linux VM
{{/if}}
- [System Requirements](pages/installation/requirements.md)
- [Upgrade Guide](pages/operations/upgrades.md)
- [Troubleshooting](pages/operations/troubleshooting.md)

## Support

If you encounter issues:

1. Generate a support bundle from the **Support** page in the app UI
2. Upload it to this portal via the **Support Bundles** tab
3. Contact support at support@astrid.fit
