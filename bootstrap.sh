apt-get install --yes python-software-properties
echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
yes | apt-add-repository ppa:developmentseed/mapbox
yes | apt-add-repository ppa:nginx/stable
apt-get update --yes
apt-get install --yes tilemill nginx-light postgresql-9.3-postgis-2.1 postgresql-contrib fonts-cantarell lmodern ttf-aenigma ttf-georgewilliams ttf-bitstream-vera ttf-sjfonts ttf-tuffy tv-fonts ubuntustudio-font-meta

tee /etc/nginx/sites-enabled/default <<FOF
server {
  listen 80;
  server_name localhost;

  location /tile/ {
    proxy_set_header Host \$http_host;
    proxy_pass http://127.0.0.1:20008;
  }

  location /datasource/ {
    proxy_set_header Host \$http_host;
    proxy_pass http://127.0.0.1:20008;
  }

  location / {
    proxy_set_header Host \$http_host;
    proxy_pass http://127.0.0.1:20009;
  }
}
FOF

tee /etc/tilemill/tilemill.config <<FOF
{
  "files": "/usr/share/mapbox",
  "server": true,
  "tileUrl": "192.168.33.10"
}
FOF

service nginx restart

start tilemill
