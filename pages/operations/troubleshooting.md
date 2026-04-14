# Troubleshooting

## Application Pod CrashLooping

**Symptom:** The astrid pod restarts repeatedly.

**Common Causes:**
- Database not reachable — check PostgreSQL pod/service status or external database connectivity
- Redis not reachable — check Redis pod/service status or external Redis connectivity
- Invalid configuration — review environment variables and Helm values

**Resolution:**
```bash
# Check pod logs
kubectl logs -l app.kubernetes.io/name=astrid --tail=50

# Check database pod
kubectl get pods -l app.kubernetes.io/name=postgresql

# Check redis pod
kubectl get pods -l app.kubernetes.io/name=redis
```

## Database Connection Refused

**Symptom:** Logs show `failed to connect to PostgreSQL` or `connection refused`.

**Resolution:**
- If using embedded PostgreSQL: ensure the PostgreSQL StatefulSet is running and the PVC is bound
- If using external PostgreSQL: verify host, port, user, password, and database name. Confirm the host is reachable from within the cluster.

## License Expired

**Symptom:** The application shows a license expiration banner or blocks access.

**Resolution:** Contact your vendor to renew your license. The application checks license validity at runtime via the Replicated SDK.

## Support Bundle Generation Fails

**Symptom:** Clicking "Generate Support Bundle" returns an error.

**Resolution:**
- Verify the Replicated SDK pod is running: `kubectl get pods -l app.kubernetes.io/name=astrid-sdk`
- Check that the ServiceAccount has the required ClusterRole permissions
- Try generating from the CLI instead (see [Support Bundles](pages/operations/support-bundles.md))
