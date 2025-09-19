#!/bin/bash -ex
VERSION=2.12
REVISION=9

wget http://deb.debian.org/debian/pool/main/g/grub2/grub2_$VERSION-$REVISION.debian.tar.xz
tar xf grub2_$VERSION-$REVISION.debian.tar.xz
rm grub2_$VERSION-$REVISION.debian.tar.xz

wget http://deb.debian.org/debian/pool/main/g/grub2/grub2_$VERSION.orig.tar.xz
tar xf grub2_$VERSION.orig.tar.xz --strip 1
rm grub2_$VERSION.orig.tar.xz

# At the time we bumped version to 2.12-1, we were not seeing efivar.c present in the debian
# source at https://deb.debian.org/debian/pool/main/g/grub2/grub2_2.12.orig.tar.xz
# which resulted in this patch failing and hence it has been removed
sed -i '/efivar-check-that-efivarfs-is-writeable.patch/d' debian/patches/series
rm -f debian/patches/efivar-check-that-efivarfs-is-writeable.patch

rm debian/patches/efi-variable-storage-minimise-writes.patch
sed -i.bak 's/efi-variable-storage-minimise-writes.patch//' debian/patches/series
rm debian/patches/series.bak

cp zpool-degraded-vdev.patch debian/patches
echo 'zpool-degraded-vdev.patch' >> debian/patches/series

cp rectify-terminal-io.patch debian/patches
echo 'rectify-terminal-io.patch' >> debian/patches/series

cp sbat_truenas_entry.patch debian/patches
echo 'sbat_truenas_entry.patch' >> debian/patches/series

cp truenas-mkrescue-install-signed-shim.patch debian/patches
echo 'truenas-mkrescue-install-signed-shim.patch' >> debian/patches/series

echo -e "$(cat changelog)\n\n$(cat debian/changelog)" > debian/changelog

sed -i.bak "s/deb_version\s*:=.\+/deb_version\t\t:= "'"'"$VERSION-$REVISION"'"'"/" debian/rules
rm debian/rules.bak

sed -i.bak "s/^version_binary.\+/version_binary="'"'"$VERSION-$REVISION"'"'"/" debian/signing-template.generate
sed -i.bak "s/^version_mangled.\+/version_mangled="'"'"$VERSION"'"'"/" debian/signing-template.generate
rm debian/signing-template.generate.bak

echo -e "\ndh_auto_test:\n" >> debian/rules
