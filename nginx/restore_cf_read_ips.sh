#!/bin/bash
echo "#Cloudflare" > /etc/nginx/conf.d/cloudflare_ip.conf;
for i in `curl https://www.cloudflare.com/ips-v4`; do
        echo "set_real_ip_from $i;" >> /etc/nginx/conf.d/cloudflare_ip.conf;
done
for i in `curl https://www.cloudflare.com/ips-v6`; do
        echo "set_real_ip_from $i;" >> /etc/nginx/conf.d/cloudflare_ip.conf;
done
echo "" >> /etc/nginx/conf.d/cloudflare_ip.conf;
echo "# use any of the following two" >> /etc/nginx/conf.d/cloudflare_ip.conf;
echo "real_ip_header CF-Connecting-IP;" >> /etc/nginx/conf.d/cloudflare_ip.conf;
echo "#real_ip_header X-Forwarded-For;" >> /etc/nginx/conf.d/cloudflare_ip.conf;
