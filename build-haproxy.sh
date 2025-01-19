export DEBFULLNAME="alive4ever"
export DEBEMAIL="alive4ever@users.noreply.github.com"
mkdir -p ~/build
cd ~/build
haproxy_dsc="https://launchpad.net/~vbernat/+archive/ubuntu/haproxy-3.0/+sourcefiles/haproxy/3.0.7-1ppa1~jammy/haproxy_3.0.7-1ppa1~jammy.dsc"
haproxy_srctarball="https://launchpad.net/~vbernat/+archive/ubuntu/haproxy-3.0/+sourcefiles/haproxy/3.0.7-1ppa1~jammy/haproxy_3.0.7.orig.tar.gz"
haproxy_debiantarball="https://launchpad.net/~vbernat/+archive/ubuntu/haproxy-3.0/+sourcefiles/haproxy/3.0.7-1ppa1~jammy/haproxy_3.0.7-1ppa1~jammy.debian.tar.xz"
for url in "$haproxy_dsc" "$haproxy_srctarball" "$haproxy_debiantarball" ; do
	curl -LO "$url"
done
dpkg-source -x haproxy_3.0.7-1ppa1~jammy.dsc
cd haproxy-3.0.7
sudo apt build-dep -y .
	dch --newversion 3.0.7-2bpo2 --distribution bookworm "Rebuild for bookworm"
	debuild -us -uc
cd ..
mkdir -p /tmp/hosttmp/haproxy_deb
cp -v *.deb /tmp/hosttmp/haproxy_deb
