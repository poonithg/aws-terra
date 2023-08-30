#!/bin/bash
apt-get update
apt-get install -y nginx

echo 
"server {
        listen 80 default_server;
        listen [::]:80 default_server;

	server_name _;

	location / {
		proxy_pass http://10.0.2.100:3000;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection keep-alive;
		proxy_set_header Host $host;
		proxy_cache_bypass $http_upgrade;
	}
}
" > /etc/nginx/sites-available/default

systemctl start nginx
systemctl enable nginx
