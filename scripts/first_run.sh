#!/bin/bash
PASS=${REDIS_PASSWORD:-$(pwgen -s -1 16)}
MAXMEMORY=${REDIS_MAXMEMORY:-31457280}

echo "Setting Redis maxmemory to $MAXMEMORY..."
sed -i -r "s/^(# maxmemory .*)$/\1\nmaxmemory $MAXMEMORY/" /etc/redis/redis.conf

echo "Securing Redis with a password..."
echo -e "\n# Secure Redis with a password\nrequirepass $PASS" >> /etc/redis/redis.conf

echo "========================================================================"
echo "Redis Password: \"$PASS\""
echo "========================================================================"

rm -f /.firstrun
