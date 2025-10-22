#!/bin/bash

. ./scripts/functions.sh

# Clone source code
clone_repo $immortalwrt_repo ${1} openwrt &
clone_repo $openwrt_pkg_repo master openwrt_pkg_ma &
clone_repo $node_prebuilt_repo packages-24.10 node &
clone_repo $openwrt_apps_repo main openwrt-apps &

# 等待所有后台任务完成
rm -rf feeds/luci/applications/luci-app-momo
rm -rf feeds/luci/applications/luci-app-alist
rm -rf feeds/luci/applications/luci-app-passwall2
git clone --depth=1 https://github.com/ophub/luci-app-amlogic package/amlogic
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/passwall-packages
git clone https://github.com/xiaorouji/openwrt-passwall2 package/luci-app-passwall2
git clone https://github.com/sbwml/luci-app-openlist2 package/luci-app-openlist2
#git_sparse_clone main https://github.com/morytyann/OpenWrt-mihomo luci-app-mihomo mihomo
git clone --depth=1 https://github.com/nikkinikki-org/OpenWrt-momo package/momo


wait
sed -i 's/ImmortalWrt/redmek40/g' package/base-files/files/bin/config_generate
# 设置默认密码为 password
sed -i 's/root:::0:99999:7:::/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.::0:99999:7:::/g' openwrt/package/base-files/files/etc/shadow
# 修改默认 IP 为 192.168.1.99
sed -i 's/192.168.1.1/192.168.110.241/g' openwrt/package/base-files/files/bin/config_generate

exit 0
