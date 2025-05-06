#!/bin/bash -ex
VERSION=2.12
REVISION=1~bpo12+1

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

cp -rf cve_2025_02_multiple/ debian/patches

echo 'cve_2025_02_multiple/misc-Implement-grub_strlcpy.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-ufs-Fix-a-heap-OOB-write.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-hfs-Fix-stack-OOB-write-with-grub_strcpy.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-tar-Initialize-name-in-grub_cpio_find_file.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-tar-Integer-overflow-leads-to-heap-OOB-write.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-f2fs-Set-a-grub_errno-if-mount-fails.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-hfsplus-Set-a-grub_errno-if-mount-fails.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-iso9660-Set-a-grub_errno-if-mount-fails.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-iso9660-Fix-invalid-free.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-jfs-Fix-OOB-read-in-jfs_getent.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-jfs-Fix-OOB-read-caused-by-invalid-dir-slot-index.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-jfs-Use-full-40-bits-offset-and-address-for-a-data-ext.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-jfs-Inconsistent-signed-unsigned-types-usage-in-return.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-ext2-Fix-out-of-bounds-read-for-inline-extents.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-xfs-Fix-out-of-bounds-read.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-xfs-Ensuring-failing-to-mount-sets-a-grub_errno.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/kern-file-Ensure-file-data-is-set.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/kern-file-Implement-filesystem-reference-counting.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/disk-loopback-Reference-tracking-for-the-loopback.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/kern-disk-Limit-recursion-depth.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/kern-partition-Limit-recursion-in-part_iterate.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/script-execute-Limit-the-recursion-depth.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/net-Unregister-net_default_ip-and-net_default_mac-variabl.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/net-Remove-variables-hooks-when-interface-is-unregisted.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/net-Fix-OOB-write-in-grub_net_search_config_file.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/net-tftp-Fix-stack-buffer-overflow-in-tftp_open.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/video-readers-jpeg-Do-not-permit-duplicate-SOF0-markers-i.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/kern-dl-Fix-for-an-integer-overflow-in-grub_dl_ref.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/kern-dl-Check-for-the-SHF_INFO_LINK-flag-in-grub_dl_reloc.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/commands-extcmd-Missing-check-for-failed-allocation.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/commands-ls-Fix-NULL-dereference.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/commands-pgp-Unregister-the-check_signatures-hooks-on-mod.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/normal-Remove-variables-hooks-on-module-unload.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/gettext-Remove-variables-hooks-on-module-unload.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/gettext-Integer-overflow-leads-to-heap-OOB-write-or-read.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/gettext-Integer-overflow-leads-to-heap-OOB-write.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/commands-read-Fix-an-integer-overflow-when-supplying-more.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/commands-test-Stack-overflow-due-to-unlimited-recursion-d.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/commands-minicmd-Block-the-dump-command-in-lockdown-mode.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/commands-memrw-Disable-memory-reading-in-lockdown-mode.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/commands-hexdump-Disable-memory-reading-in-lockdown-mode.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-bfs-Disable-under-lockdown.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-Disable-many-filesystems-under-lockdown.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/disk-Use-safe-math-macros-to-prevent-overflows.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/disk-Prevent-overflows-when-allocating-memory-for-arrays.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/disk-Check-if-returned-pointer-for-allocated-memory-is-NU.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/disk-ieee1275-ofdisk-Call-grub_ieee1275_close-when-grub_m.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-Use-safe-math-macros-to-prevent-overflows.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-Prevent-overflows-when-allocating-memory-for-arrays.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-Prevent-overflows-when-assigning-returned-values-from-.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-zfs-Use-safe-math-macros-to-prevent-overflows.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-zfs-Prevent-overflows-when-allocating-memory-for-array.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-zfs-Check-if-returned-pointer-for-allocated-memory-is-.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-zfs-Add-missing-NULL-check-after-grub_strdup-call.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/net-Use-safe-math-macros-to-prevent-overflows.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/net-Prevent-overflows-when-allocating-memory-for-arrays.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/net-Check-if-returned-pointer-for-allocated-memory-is-NUL.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-sfs-Check-if-allocated-memory-is-NULL.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/script-execute-Fix-potential-underflow-and-NULL-dereferen.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/osdep-unix-getroot-Fix-potential-underflow.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/misc-Ensure-consistent-overflow-error-messages.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/bus-usb-ehci-Define-GRUB_EHCI_TOGGLE-as-grub_uint32_t.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/normal-menu-Use-safe-math-to-avoid-an-integer-overflow.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/kern-partition-Add-sanity-check-after-grub_strtoul-call.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/kern-misc-Add-sanity-check-after-grub_strtoul-call.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/loader-i386-linux-Cast-left-shift-to-grub_uint32_t.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/loader-i386-bsd-Use-safe-math-to-avoid-underflow.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-ext2-Rework-out-of-bounds-read-for-inline-and-external.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-xfs-Fix-grub_xfs_iterate_dir-return-value-in-case-of-f.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-xfs-Propagate-incorrect-inode-error-from-grub_xfs_read.patch' >> debian/patches/series
echo 'cve_2025_02_multiple/fs-xfs-Handle-root-inode-read-failure-in-grub_xfs_mount.patch' >> debian/patches/series

cp sbat_to_5.patch debian/patches
echo 'sbat_to_5.patch' >> debian/patches/series

cp truenas-mkrescue-install-signed-shim.patch debian/patches
echo 'truenas-mkrescue-install-signed-shim.patch' >> debian/patches/series

echo -e "$(cat changelog)\n\n$(cat debian/changelog)" > debian/changelog

sed -i.bak "s/deb_version\s*:=.\+/deb_version\t\t:= "'"'"$VERSION-$REVISION"'"'"/" debian/rules
rm debian/rules.bak

sed -i.bak "s/^version_binary.\+/version_binary="'"'"$VERSION-$REVISION"'"'"/" debian/signing-template.generate
sed -i.bak "s/^version_mangled.\+/version_mangled="'"'"$VERSION"'"'"/" debian/signing-template.generate
rm debian/signing-template.generate.bak

echo -e "\ndh_auto_test:\n" >> debian/rules
