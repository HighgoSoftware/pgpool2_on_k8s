#!/bin/bash

# Start cron daemon
echo "Starting cronjob..."
sudo crontab -u postgres /var/lib/pgsql/crontab/cronjob
sudo crond -b -l 4

echo "Syncing endpoint nodes"
res=$(curl --request GET "http://handler-service:8989/endpoint" \
              --header 'Content-Type: application/json' \
              --data '{}' | jq ".[] | .name" | sed 's/^"\(.*\)"$/\1/')

for name in $res; do
	echo "populate backend node for $name"
	/proxy-scripts/poolnodes.sh addnode $name
done

# Start Pgpool-II
echo "Starting Pgpool-II..."
${PGPOOL_INSTALL_DIR}/bin/pgpool -n \
    -f ${PGPOOL_INSTALL_DIR}/etc/pgpool.conf \
    -F ${PGPOOL_INSTALL_DIR}/etc/pcp.conf \
    -a ${PGPOOL_INSTALL_DIR}/etc/pool_hba.conf \
    -k ${PGPOOL_INSTALL_DIR}/etc/.pgpoolkey
