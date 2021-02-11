REQUIRE_IMAGE_METADATA=1

CI_KERNPART=kernel
CI_ROOTPART=rootfs

fixed_size_mtd_do_upgrade() {
	local append
	local sysup_file="$1"

	local board_dir=$(tar tf $sysup_file | grep -m 1 '^sysupgrade-.*/$')

	[ -f "$UPGRADE_BACKUP" ] && append="-j $UPGRADE_BACKUP"
	tar xf $sysup_file ${board_dir}kernel ${board_dir}root -O | \
		mtd -r $append write - $CI_KERNPART:$CI_ROOTPART
}

platform_check_image() {
	return 0
}

platform_do_upgrade() {
	local board=$(board_name)

	case "$board" in
	zoomgo,zx10)
		fixed_size_mtd_do_upgrade "$IMAGE"
		;;
	*)
		default_do_upgrade "$IMAGE"
		;;
	esac
}
