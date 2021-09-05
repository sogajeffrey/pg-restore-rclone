Postgres Restore with Rclone
================

Docker image with psql and rclone to restore postgres from a backup Published to sogajeffrey/pg-restore-rclone


## Environment Variables:
| Variable | Required? | Default | Description |
| -------- |:--------- |:------- |:----------- |
| `PGUSER` | Required | postgres | The user for accessing the database |
| `PGPASSWORD` | Optional | `None` | The password for accessing the database |
| `PGHOST` | Optional | db | The hostname of the database |
| `PGPORT` | Optional | `5432` | The port for the database |
| `RCLONE_REMOTE` | Required | `None` | The configured rclone remote mounted from /root |
| `RCLONE_PATH` | Required | `None` | Path in your rclone backup target. Do not put trailing / |
| `BACKUP_VERSION` | Required | `None` | Version of backup you want to restore (Full file name with extension) / |




