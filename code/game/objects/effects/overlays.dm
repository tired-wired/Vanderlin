/obj/effect/overlay
	name = "overlay"

/obj/effect/overlay/sparkles
	gender = PLURAL
	name = "sparkles"
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldsparkles"
	anchored = TRUE

/obj/effect/overlay/vis
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	anchored = TRUE
	vis_flags = VIS_INHERIT_DIR
	var/unused = 0 //When detected to be unused it gets set to world.time, after a while it gets removed
	var/cache_expiration = 2 MINUTES // overlays which go unused for 2 minutes get cleaned up
