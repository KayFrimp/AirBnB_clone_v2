#!/usr/bin/env bash
# Script to prepare web servers
if ! command -v nginx &>/dev/null; then
	sudo apt-get -y update
	sudo apt-get -y install nginx
fi

web_static_test="/data/web_static/releases/test"
web_static_shared="/data/web_static/shared"

sudo mkdir -p "$web_static_test"
sudo mkdir -p "$web_static_shared"

sudo echo "<html><head></head><body>Holberton School</body></html>" | sudo tee "$web_static_test/index.html"

current_link="/data/web_static/current"

if [ -L $current_link ]; then
	sudo rm "$current_link"
fi

sudo ln -s -f "$web_static_test" "$current_link"

sudo chown -R ubuntu:ubuntu /data/

config_file="/etc/nginx/sites-available/default"
nginx_config="location /hbnb_static/ {\n    alias $current_link/;\n}\n"

if ! grep -q 'location /hbnb_static/' "$config_file"; then
    sudo sed -i "/server {/a $nginx_config" "$config_file"
fi

sudo service nginx restart

exit 0
