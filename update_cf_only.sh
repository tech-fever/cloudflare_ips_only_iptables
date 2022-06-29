#!/bin/bash

#先删掉"不允许所有"，避免在下面命令执行期间GG
iptables -D CLOUDFLARE -j DROP
ip6tables -D CLOUDFLARE -j DROP

#清除规则(旧的CF IP)
iptables -F CLOUDFLARE
ip6tables -F CLOUDFLARE
#添加CF IP，下面可以对curl的结果做一次判断，可以避免网络问题可能出现的问题，自己写
for ip in `curl https://www.cloudflare.com/ips-v4`; do
        iptables -A CLOUDFLARE -s $ip -j RETURN;
done

for ip in `curl https://www.cloudflare.com/ips-v6`; do
        ip6tables -A CLOUDFLARE -s $ip -j RETURN;
done

# 自己判断是否要保存，个人觉得可以手动执行脚本，之后看要不要保存
#mkdir -p /etc/iptables/
# iptables-save > /etc/iptables/rules.v4
# ip6tables-save > /etc/iptables/rules.v6

# 记录并禁用其他IP
iptables -A CLOUDFLARE -j LOG --log-prefix "IPTABLES_CLOUDFLARE_ONLY_BANNED: "
ip6tables -A CLOUDFLARE -j LOG --log-prefix "IP6TABLES_CLOUDFLARE_ONLY_BANNED: "

iptables -A CLOUDFLARE -j DROP
ip6tables -A CLOUDFLARE -j DROP
