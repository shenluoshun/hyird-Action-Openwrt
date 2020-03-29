#add sonme additional packages
git clone https://github.com/rufengsuixing/luci-app-adguardhome             package/adg
git clone https://github.com/destan19/OpenAppFilter                         package/oaf
git clone https://github.com/Advanced-noob/luci-theme-atmaterial.git        package/atmaterial
git clone https://github.com/vernesong/OpenClash                            package/clash
git clone https://github.com/tty228/luci-app-serverchan.git                 package/serverchan
git clone https://github.com/hyird/feed-netkeeper.git -b openwrt-18.06      package/netkeeper
ln -s ../../diy/myipk ./package/




cat > package/lean/default-settings/files/zzz-default-settings<<-EOF
#!/bin/sh
uci set luci.main.lang=zh_cn
uci commit luci

uci set system.@system[0].timezone=CST-8
uci set system.@system[0].zonename=Asia/Shanghai
uci commit system

uci set fstab.@global[0].anon_mount=1
uci commit fstab

uci set network.globals.ula_prefix=''
uci commit network

rm -f /usr/lib/lua/luci/view/admin_status/index/mwan.htm
rm -f /usr/lib/lua/luci/view/admin_status/index/upnp.htm
rm -f /usr/lib/lua/luci/view/admin_status/index/ddns.htm
rm -f /usr/lib/lua/luci/view/admin_status/index/minidlna.htm

sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/aria2.lua
sed -i 's/services/nas/g' /usr/lib/lua/luci/view/aria2/overview_status.htm
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/hd_idle.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/samba.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/minidlna.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/transmission.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/mjpg-streamer.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/p910nd.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/usb_printer.lua
sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/xunlei.lua
sed -i 's/services/nas/g'  /usr/lib/lua/luci/view/minidlna_status.htm

ln -sf /sbin/ip /usr/bin/ip

sed -i 's/downloads.openwrt.org/op.hyird.xyz/g' /etc/opkg/distfeeds.conf
sed -i 's/snapshots/$(cat ../version)/g' /etc/opkg/distfeeds.conf
sed -i "s/# //g" /etc/opkg/distfeeds.conf

sed -i '/REDIRECT --to-ports 53/d' /etc/firewall.user
echo "iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 53" >> /etc/firewall.user
echo "iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-ports 53" >> /etc/firewall.user

sed -i '/option disabled/d' /etc/config/wireless
sed -i '/set wireless.radio${devidx}.disabled/d' /lib/wifi/mac80211.sh

sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='$(cat ../version)'" >> /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='OpenWrt '" >> /etc/openwrt_release

sed -i '/log-facility/d' /etc/dnsmasq.conf
echo "log-facility=/dev/null" >> /etc/dnsmasq.conf

sed -i 's/cbi.submit\"] = true/cbi.submit\"] = \"1\"/g' /usr/lib/lua/luci/dispatcher.lua

rm -rf /tmp/luci-modulecache/
rm -f /tmp/luci-indexcache

exit 0

EOF

cat << EOF >> target/linux/ipq40xx/config-4.14
CONFIG_PMBUS=n
CONFIG_SENSORS_PMBUS=n
CONFIG_SENSORS_ADM1275=n
CONFIG_SENSORS_IBM_CFFPS=n
CONFIG_SENSORS_IR35221=n
CONFIG_SENSORS_LM25066=n
CONFIG_SENSORS_LTC2978=n
CONFIG_SENSORS_LTC3815=n
CONFIG_SENSORS_MAX16064=n
CONFIG_SENSORS_MAX20751=n
CONFIG_SENSORS_MAX34440=n
CONFIG_SENSORS_MAX8688=n
CONFIG_SENSORS_TPS40422=n
CONFIG_SENSORS_TPS53679=n
CONFIG_SENSORS_UCD9000=n
CONFIG_SENSORS_UCD9000=n
CONFIG_SENSORS_UCD9200=n
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=n
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_LOGGING=y
EOF


cat << EOF >> target/linux/ramips/mt7621/config-4.14
CONFIG_PMBUS=n
CONFIG_SENSORS_PMBUS=n
CONFIG_SENSORS_ADM1275=n
CONFIG_SENSORS_IBM_CFFPS=n
CONFIG_SENSORS_IR35221=n
CONFIG_SENSORS_LM25066=n
CONFIG_SENSORS_LTC2978=n
CONFIG_SENSORS_LTC3815=n
CONFIG_SENSORS_MAX16064=n
CONFIG_SENSORS_MAX20751=n
CONFIG_SENSORS_MAX34440=n
CONFIG_SENSORS_MAX8688=n
CONFIG_SENSORS_TPS40422=n
CONFIG_SENSORS_TPS53679=n
CONFIG_SENSORS_UCD9000=n
CONFIG_SENSORS_UCD9000=n
CONFIG_SENSORS_UCD9200=n
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=n
CONFIG_DMA_JZ4780=n
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_LOGGING=y
EOF

cat << EOF >> target/linux/x86/config-4.19
CONFIG_HSA_AMD=n
CONFIG_MTD_SBC_GXX=y
EOF



