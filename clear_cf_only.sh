iptables  -F CLOUDFLARE
ip6tables -F CLOUDFLARE
iptables  -D INPUT -p tcp -m multiport --dports http,https -j CLOUDFLARE
ip6tables -D INPUT -p tcp -m multiport --dports http,https -j CLOUDFLARE
iptables  -X CLOUDFLARE
ip6tables -X CLOUDFLARE
# 删除保存的规则并存入最新的（自己判断要不要去掉注释）
#> /etc/iptables/rules.v4
#> /etc/iptables/rules.v6
# iptables-save > /etc/iptables/rules.v4
# ip6tables-save > /etc/iptables/rules.v6
