#!/bin/bash
# nginx 恢复cloudflare的真实ip

# 读取命令行参数中的nginx配置文件路径

# nginx_conf 为空就退出
if [ -z "$1" ]; then
    echo "nginx_conf is null"
    exit 1
fi
# 配置文件路径是否存在
nginx_conf=$1
if [ ! -d "$nginx_conf" ]; then
    echo $nginx_conf "not exist"
    echo "nginx_conf does not exist"
    exit 1
fi

restore_real_ip_config_file="restore_real_ip.conf"

config_file_full_path="${nginx_conf}/${restore_real_ip_config_file}"

echo "#Cloudflare" > $config_file_full_path;
for i in `curl https://www.cloudflare.com/ips-v4`; do
        echo "set_real_ip_from $i;" >> $config_file_full_path;
done
for i in `curl https://www.cloudflare.com/ips-v6`; do
        echo "set_real_ip_from $i;" >> $config_file_full_path;
done
echo "" >> $config_file_full_path;
echo "# use any of the following two" >> $config_file_full_path;
echo "real_ip_header CF-Connecting-IP;" >> $config_file_full_path;
echo "#real_ip_header X-Forwarded-For;" >> $config_file_full_path;

# 结束
echo "恢复cloudflare的真实ip成功"
# 文件路径为
echo "文件路径为：${config_file_full_path}"
