export DEBFULLNAME="alive4ever"
export DEBEMAIL="alive4ever@users.noreply.github.com"
export HAPROXY_VERSION="3.0.8"
export PPA_VERSION="1ppa1~jammy"
export BACKPORT_VERSION="1bpo1"
mkdir -p ~/build
cd ~/build
curl -L "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3d653970fbab0a890e4e4e9a0f14d8b0cf4efe96" | sudo tee /etc/apt/keyrings/haproxy-ppa.asc
cat << EOL | sudo tee /etc/apt/sources.list.d/haproxy-ppa.list
deb-src [signed-by=/etc/apt/keyrings/haproxy-ppa.asc] https://ppa.launchpadcontent.net/vbernat/haproxy-3.0/ubuntu jammy main
EOL
sudo apt update
apt source --download-only haproxy
dpkg-source -x haproxy_${HAPROXY_VERSION}-${PPA_VERSION}.dsc
cd haproxy-${HAPROXY_VERSION}
sudo apt build-dep -y .
dch -b --newversion ${HAPROXY_VERSION}-${BACKPORT_VERSION} --distribution bookworm "Rebuild for bookworm"
debuild -us -uc
cd ..
mkdir -p /tmp/hosttmp/haproxy_deb
cp -v *.deb /tmp/hosttmp/haproxy_deb
