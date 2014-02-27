# sed -n '1{p;q}' /proc/meminfo

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
sudo dpkg-reconfigure locales

su -l -c "createdb -E UTF8 --locale=en_US.utf8 -T template0 template_postgis" - postgres

su -l -c "psql -d template_postgis -c 'CREATE EXTENSION postgis;'" - postgres
su -l -c "psql -d template_postgis -c 'CREATE EXTENSION postgis_topology;'" - postgres
#su -l -c "psql -d template_postgis -c 'CREATE EXTENSION postgis_tiger_geocoder;'" - postgres

# install adminpack for postgresql
su -l -c "psql -c 'CREATE EXTENSION adminpack;'" - postgres

#createuser -d -E -i -l -r -s tilemill
