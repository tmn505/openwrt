#!/bin/sh

. /lib/functions.sh
. /lib/functions/leds.sh

get_leds() {
	case "$(board_name)" in
	wyse,tx0)
		boot="green:status"
		failsafe="amber:status"
		running="green:status"
		upgrade="amber:status"
		;;
	*)
		boot="$(get_dt_led boot)"
		failsafe="$(get_dt_led failsafe)"
		running="$(get_dt_led running)"
		upgrade="$(get_dt_led upgrade)"
		;;
	esac
}

set_state() {
	get_leds

	case "$1" in
	preinit)
		status_led="$failsafe"
		status_led_off
		status_led="$boot"
		status_led_blink_preinit
		;;
	failsafe)
		status_led="$boot"
		status_led_off
		status_led="$running"
		status_led_off
		status_led="$failsafe"
		status_led_blink_failsafe
		;;
	preinit_regular)
		status_led="$boot"
		status_led_blink_preinit_regular
		;;
	upgrade)
		status_led="$running"
		status_led_off
		status_led="$upgrade"
		status_led_blink_preinit_regular
		;;
	done)
		status_led="$boot"
		status_led_off
		status_led="$running"
		status_led_on
		;;
	esac
}
