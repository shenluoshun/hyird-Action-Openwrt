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
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=n
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=n
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=n
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=n
CONFIG_ALTERA_TSE=n
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=n
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=n
CONFIG_PCNET32=m
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=n
CONFIG_NET_CADENCE=y
CONFIG_MACB=n
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_BCMGENET=n
CONFIG_BNX2=m
CONFIG_CNIC=n
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=n
CONFIG_BNX2X=m
CONFIG_SYSTEMPORT=n
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=n
CONFIG_CHELSIO_T3=n
CONFIG_CHELSIO_T4=n
CONFIG_CHELSIO_T4VF=n
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_CS89x0=n
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_DM9000=m
CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
CONFIG_DNET=n
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=n
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=n
CONFIG_SUNDANCE=n
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=n
CONFIG_NET_VENDOR_EXAR=y
CONFIG_S2IO=n
CONFIG_VXGE=n
CONFIG_NET_VENDOR_FARADAY=y
CONFIG_FTMAC100=n
CONFIG_FTGMAC100=n
CONFIG_NET_VENDOR_HISILICON=y
CONFIG_HIX5HD2_GMAC=n
CONFIG_HISI_FEMAC=n
CONFIG_HIP04_ETH=n
CONFIG_HNS=n
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
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_TYPHOON=n
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=n
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=m
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=n
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=n
CONFIG_ALTERA_TSE=n
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=n
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=n
CONFIG_PCNET32=m
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=n
CONFIG_NET_CADENCE=y
CONFIG_MACB=n
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_BCMGENET=n
CONFIG_BNX2=m
CONFIG_CNIC=n
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=n
CONFIG_BNX2X=m
CONFIG_SYSTEMPORT=n
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=n
CONFIG_CHELSIO_T3=n
CONFIG_CHELSIO_T4=n
CONFIG_CHELSIO_T4VF=n
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_CS89x0=n
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_DM9000=m
CONFIG_DM9000_FORCE_SIMPLE_PHY_POLL=y
CONFIG_DNET=n
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=n
CONFIG_TULIP=m
CONFIG_TULIP_MWI=y
CONFIG_TULIP_MMIO=y
CONFIG_TULIP_NAPI=y
CONFIG_TULIP_NAPI_HW_MITIGATION=y
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_NET_VENDOR_DLINK=y
CONFIG_DL2K=n
CONFIG_SUNDANCE=n
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=n
CONFIG_NET_VENDOR_EXAR=y
CONFIG_S2IO=n
CONFIG_VXGE=n
CONFIG_NET_VENDOR_FARADAY=y
CONFIG_FTMAC100=n
CONFIG_FTGMAC100=n
CONFIG_NET_VENDOR_HISILICON=y
CONFIG_HIX5HD2_GMAC=n
CONFIG_HISI_FEMAC=n
CONFIG_HIP04_ETH=n
CONFIG_HNS=n
EOF

cat << EOF >> target/linux/x86/config-4.19
CONFIG_HSA_AMD=n
EOF



