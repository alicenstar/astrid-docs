# Feature Configuration

{{ app.name }} includes optional features that can be enabled or disabled.

{{#if entitlements.workout_streaks_enabled}}
## Workout Streaks

Track consecutive workout days with streak counts and weekly progress visualization.

### Helm Values

```yaml
features:
  streaksEnabled: true   # default
```

### Embedded Cluster

Toggle **Workout Streaks** on the Features configuration screen.
{{/if}}

## Google OAuth

Enable Google sign-in alongside email/password authentication.

### Prerequisites

- A Google Cloud project with OAuth 2.0 credentials
- Authorized redirect URI: `https://<your-domain>/auth/google/callback`

### Helm Values

```yaml
auth:
  google:
    clientID: "your-client-id.apps.googleusercontent.com"
    clientSecret: "your-client-secret"
    redirectURL: "https://your-domain/auth/google/callback"
```

### Embedded Cluster

Toggle **Google OAuth** on the Features configuration screen and enter your Google OAuth credentials.
