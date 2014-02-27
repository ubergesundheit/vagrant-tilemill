Sources:
- https://github.com/stevage/tilemill-server
- http://postgis.net/docs/postgis_installation.html
- https://github.com/rogelio2k/chef-cookbook-postgis2
- http://switch2osm.org/serving-tiles/manually-building-a-tile-server-12-04
- http://wiki.openstreetmap.org/wiki/Osm2pgsql


notes/postgres:
CREATE EXTENSION hstore

sudo apt-get install build-essential libxml2-dev libgeos++-dev libpq-dev libbz2-dev proj libtool automake subversion

sudo apt-get install libprotobuf-c0-dev protobuf-c-compiler



./autogen.sh
./configure

sed -i 's/-g -O2/-O2 -march=native -fomit-frame-pointer/' Makefile

make
sudo make install

createuser gis
psql -c "alter user gis with password 'gis';"
createdb -T template_postgis -O gis gis

local all all md5
restart
osm2pgsql -W -c -G -U gis -d gis muenster-regbez-latest.osm.pbf

clone osm-bright
do as it says

remove first three things from .mml
