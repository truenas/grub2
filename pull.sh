#!/bin/bash -ex
VERSION=2.04
REVISION=19

wget http://deb.debian.org/debian/pool/main/g/grub2/grub2_$VERSION-$REVISION.debian.tar.xz
tar xf grub2_$VERSION-$REVISION.debian.tar.xz
rm grub2_$VERSION-$REVISION.debian.tar.xz

wget http://deb.debian.org/debian/pool/main/g/grub2/grub2_$VERSION.orig.tar.xz
tar xf grub2_$VERSION.orig.tar.xz --strip 1
rm grub2_$VERSION.orig.tar.xz

rm debian/patches/efi-variable-storage-minimise-writes.patch
sed -i.bak 's/efi-variable-storage-minimise-writes.patch//' debian/patches/series
rm debian/patches/series.bak

echo -e "$(cat changelog)\n\n$(cat debian/changelog)" > debian/changelog
