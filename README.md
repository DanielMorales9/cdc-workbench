# Testing Environment

A repeatable, and reproducible testing environment for the Streaming Platform.

Required environment variables:
- `GOOGLE_APPLICATION_CREDENTIALS`
- `PROPERTIES_TEMPLATE`

## Startup
```
docker-compose up --build
```

## Testing
Run `pgbench` to produce data on the side of the DB or simply use `psql`.
```bash
pgbench -U postgres -h localhost -i -s 5 -I G postgres
```

## Teardown
```
docker-compose down
```

## Troubleshooting
Active CDC processes 
```sql
SELECT pid,
     usename,
     datname,
     client_addr,
     application_name,
     backend_start,
     state,
     state_change
FROM pg_stat_activity 
WHERE usename='cdc';
```

List all publications
```sql
SELECT * 
FROM pg_publication_tables;
```

Replication lag
```sql
SELECT pg_current_wal_lsn() - restart_lsn AS replication_lag_bytes
FROM pg_replication_slots
WHERE slot_name = 'cdc_slot';
```

List of mapping publications and table
```sql
SELECT * 
FROM pg_publication;
```
