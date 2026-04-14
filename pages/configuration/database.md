# Database Configuration

{{ app.name }} requires PostgreSQL and Redis. Both can run as embedded components within the cluster or connect to external instances you manage.

## Embedded (Default)

By default, PostgreSQL and Redis are deployed as Helm subcharts inside the cluster. No additional configuration is needed.

### Helm Values

```yaml
# These are the defaults — no changes needed for embedded mode
postgresql:
  enabled: true
redis:
  enabled: true
```

### Embedded Cluster

Select **Embedded** on the database configuration screen during installation.

## External (Bring Your Own)

To use existing PostgreSQL and Redis instances:

### Helm Values

```yaml
postgresql:
  enabled: false
externalDatabase:
  host: "your-postgres-host.example.com"
  port: 5432
  user: "astrid"
  password: "your-password"
  database: "astrid"

redis:
  enabled: false
externalRedis:
  host: "your-redis-host.example.com"
  port: 6379
  password: ""
```

### Embedded Cluster

Select **External** on the database configuration screen and fill in the connection fields. The embedded PostgreSQL/Redis pods will not be created.

## Requirements

### PostgreSQL

- Version 16+
- A database named `astrid` (or your chosen name)
- A user with full privileges on that database
- The `uuid-ossp` extension enabled

### Redis

- Version 7+
- Authentication optional (set password to empty string if disabled)
