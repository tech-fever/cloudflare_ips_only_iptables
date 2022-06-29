# !/bin/bash
#
# Configure your iptables to allow IPs from Cloudflare only.
# For users whose HTTP server is directly exposed to the host 80/443.

iptables -N CLOUDFLARE
ip6tables -N CLOUDFLARE

# 可以换成 -A
iptables  -I INPUT -p tcp -m multiport --dports http,https -j CLOUDFLARE
ip6tables -I INPUT -p tcp -m multiport --dports http,https -j CLOUDFLARE

for ip in `curl https://www.cloudflare.com/ips-v4`; do
        iptables -A CLOUDFLARE -s $ip -j RETURN;
done

for ip in `curl https://www.cloudflare.com/ips-v6`; do
        ip6tables -A CLOUDFLARE -s $ip -j RETURN;
done

iptables -A CLOUDFLARE -j LOG --log-prefix "IPTABLES_CLOUDFLARE_ONLY_BANNED: "
ip6tables -A CLOUDFLARE -j LOG --log-prefix "IP6TABLES_CLOUDFLARE_ONLY_BANNED: "

iptables -A CLOUDFLARE -j DROP
iptables -A CLOUDFLARE -j DROP
