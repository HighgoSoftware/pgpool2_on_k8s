#!/bin/bash

# Start cron daemon
echo "Starting cronjob..."
sudo crontab -u postgres /var/lib/pgsql/crontab/cronjob
sudo crond -b -l 4

# Start Pgpool-II
echo "Starting Pgpool-II..."
${PGPOOL_INSTALL_DIR}/bin/pgpool -n \
    -f ${PGPOOL_INSTALL_DIR}/etc/pgpool.conf \
    -F ${PGPOOL_INSTALL_DIR}/etc/pcp.conf \
    -a ${PGPOOL_INSTALL_DIR}/etc/pool_hba.conf \
    -k ${PGPOOL_INSTALL_DIR}/etc/.pgpoolkey
