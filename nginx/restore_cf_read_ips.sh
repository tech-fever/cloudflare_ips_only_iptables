#!/bin/bash
# nginx 恢复cloudflare的真实ip

# 读取命令行参数中的nginx配置文件路径
nginx_conf=$1
restore_real_ip_config_file="restore_real_ip.conf"

config_file_full_path="${nginx_conf}/${restore_real_ip_config_file}"

echo "#Cloudflare" > config_file_full_path;
for i in `curl https://www.cloudflare.com/ips-v4`; do
        echo "set_real_ip_from $i;" >> config_file_full_path;
done
for i in `curl https://www.cloudflare.com/ips-v6`; do
        echo "set_real_ip_from $i;" >> config_file_full_path;
done
echo "" >> config_file_full_path;
echo "# use any of the following two" >> config_file_full_path;
echo "real_ip_header CF-Connecting-IP;" >> config_file_full_path;
echo "#real_ip_header X-Forwarded-For;" >> config_file_full_path;
