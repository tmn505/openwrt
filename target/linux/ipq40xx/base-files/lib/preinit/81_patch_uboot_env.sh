. /lib/functions.sh

preinit_patch_uboot_env() {
	case $(board_name) in
	pakedge,wr-1)
		if ! fw_printenv -n OpenWrt &>/dev/null; then
			fw_setenv OpenWrt 'sf probe; sf read 0x84000000 0x180000 0x800000; bootm 0x84000000'
			fw_setenv bootcmd "$(fw_printenv -n bootcmd | sed -e 's,bootipq,run OpenWrt,')"
		fi
		;;
	esac
}

boot_hook_add preinit_main preinit_patch_uboot_env
