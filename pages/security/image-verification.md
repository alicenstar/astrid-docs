# Image Verification

All {{ app.name }} container images are signed using [cosign](https://docs.sigstore.dev/cosign/overview/) with keyless signing via GitHub Actions OIDC. You can verify image authenticity before deploying.

## Verify an Image

```bash
cosign verify \
  --certificate-identity "https://github.com/alicenstar/astrid/.github/workflows/release.yaml@refs/heads/main" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com" \
  alicenstar/astrid:<tag>
```

Replace `<tag>` with the version you are deploying (e.g., `0.1.0`, `latest`).

## What This Proves

- The image was built by the official {{ app.name }} GitHub Actions release workflow
- The image has not been tampered with since it was built
- The signing identity is tied to the GitHub repository, not a manually managed key

## Signature Storage

Signatures are stored as OCI artifacts in Docker Hub alongside the image. The signing event is also recorded in the [Rekor transparency log](https://search.sigstore.dev/) for public auditability.

## Requirements

- [cosign](https://docs.sigstore.dev/cosign/installation/) v2.0+
