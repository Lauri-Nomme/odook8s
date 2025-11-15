set -x

ver=$(cat ver)

# apt download odoo=$(cat ver)
# fails, odiots screwed up their debian repo

[ -e *${ver}_all.deb ] || wget https://nightly.odoo.com/15.0/nightly/deb/odoo_${ver}.dsc \
 https://nightly.odoo.com/15.0/nightly/deb/odoo_${ver}.tar.xz \
 https://nightly.odoo.com/15.0/nightly/deb/odoo_${ver}_all.deb \
 https://nightly.odoo.com/15.0/nightly/deb/odoo_${ver}_amd64.changes 

# extract requirements.txt for pip install in container
[ -e src/requirements.txt ] || tar xvf odoo_$(cat ver).tar.xz src/requirements.txt -C .

# extract the debian package to stash into container
[ -e fs ] || dpkg-deb -x odoo_${ver}_all.deb fs

