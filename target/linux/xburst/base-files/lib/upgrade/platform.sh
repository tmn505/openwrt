REQUIRE_IMAGE_METADATA=1
PART_NAME=firmware

platform_check_image() {
	return 0
}

platform_do_upgrade() {
	default_do_upgrade "$IMAGE"
}
