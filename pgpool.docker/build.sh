docker build --no-cache --build-arg PGPOOL_VER=4.4.3 --build-arg PGPOOL_BRANCH=hg-private-deploy -f Dockerfile.pgpool-release -t hgneon/pgpool:v4.4.3 .

## run below command manually for more build information
#docker build --no-cache --build-arg PGPOOL_VER=4.4.3 --build-arg PGPOOL_BRANCH=hg-private-deploy -f Dockerfile.pgpool -t hgneon/pgpool:v4.4.3 . --progress plain
