
/obj/structure/window
	name = "window"
	desc = "A window of simple paned glass."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "window-solid"
	layer = TABLE_LAYER
	density = TRUE
	anchored = TRUE
	opacity = FALSE
	pass_flags_self = PASSWINDOW|PASSSTRUCTURE
	max_integrity = 100
	integrity_failure = 0.1
	blade_dulling = DULLING_BASHCHOP
	climb_time = 20
	climb_offset = 10
	attacked_sound = 'sound/combat/hits/onglass/glasshit.ogg'
	break_sound = "glassbreak"
	destroy_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'

	var/lockdir = 0
	var/brokenstate = 0

	var/repairable = TRUE
	var/repair_state = 0
	var/obj/item/repair_cost_first = /obj/item/natural/glass
	var/obj/item/repair_cost_second = /obj/item/grown/log/tree/small
	var/repair_skill = /datum/skill/craft/masonry // i copypasted this code from the repairable doors and now it's got defines in the base

/obj/structure/window/Initialize()
	. = ..()
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/window/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)][brokenstate ? "br" : ""]"

/obj/structure/window/proc/repairwindow(obj/item/I, mob/user)
	if(brokenstate)
		switch(repair_state)
			if(0)
				if(istype(I, repair_cost_first))
					user.visible_message(span_notice("[user] starts repairing [src]."), \
					span_notice("I start repairing [src]."))
					playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
					if(do_after(user, (30 SECONDS / user.get_skill_level(repair_skill)), src)) // 1 skill = 30 secs, 2 skill = 15 secs etc.
						qdel(I)
						playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
						repair_state = 1
						var/obj/cast_repair_cost_second = repair_cost_second
						to_chat(user, span_notice("An additional [initial(cast_repair_cost_second.name)] is needed to finish the job."))
			if(1)
				if(istype(I, repair_cost_second))
					user.visible_message(span_notice("[user] starts repairing [src]."), \
					span_notice("I start repairing [src]."))
					playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
					if(do_after(user, (30 SECONDS / user.get_skill_level(repair_skill)), src)) // 1 skill = 30 secs, 2 skill = 15 secs etc.
						qdel(I)
						playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
						icon_state = "[initial(icon_state)]"
						density = TRUE
						opacity = TRUE
						brokenstate = FALSE
						obj_broken = FALSE
						obj_integrity = max_integrity
						repair_state = 0
						user.visible_message(span_notice("[user] repaired [src]."), \
						span_notice("I repaired [src]."))
	else
		if(obj_integrity < max_integrity && istype(I, repair_cost_first))
			to_chat(user, span_warning("[obj_integrity]"))
			user.visible_message(span_notice("[user] starts repairing [src]."), \
			span_notice("I start repairing [src]."))
			playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
			if(do_after(user, (30 SECONDS / user.get_skill_level(repair_skill)), src)) // 1 skill = 30 secs, 2 skill = 15 secs etc.
				qdel(I)
				playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
				obj_integrity = obj_integrity + (max_integrity/2)
				if(obj_integrity > max_integrity)
					obj_integrity = max_integrity
				user.visible_message(span_notice("[user] repaired [src]."), \
				span_notice("I repaired [src]."))

/obj/structure/window/attack_ghost(mob/dead/observer/user)	// lets ghosts click on windows to transport across
	density = FALSE
	. = step(user,get_dir(user,src.loc))
	density = TRUE

/obj/structure/window/solid
	desc = "A window of simple paned glass."
	icon_state = "window-solid"
	integrity_failure = 0.5

/obj/structure/window/stained
	icon_state = "stained-silver"
	max_integrity = 100
	integrity_failure = 0.75
	repair_cost_first = /obj/item/natural/glass
	repair_cost_second = /obj/item/natural/stone

/obj/structure/window/stained/silver
	desc = "A stained-glass window filigreed in silver."
	icon_state = "stained-silver"
	max_integrity = 100
	integrity_failure = 0.75

/obj/structure/window/stained/silver/alt
	icon_state = "stained-silver1"

/obj/structure/window/stained/zizo
	desc = "A stained-glass window filigreed in deep crimson."
	icon_state = "stained-zizo"

/obj/structure/window/stained/yellow
	desc = "A stained-glass window filigreed in gold."
	icon_state = "stained-yellow"

/obj/structure/window/openclose
	desc = "It opens and closes."
	icon_state = MAP_SWITCH("woodwindow", "woodwindowdir")
	max_integrity = 100
	integrity_failure = 0.5

/obj/structure/window/openclose/Initialize()
	. = ..()
	lockdir = dir
	GLOB.TodUpdate += src
	var/static/list/loc_connections = list(
		COMSIG_ATOM_MAGICALLY_UNLOCKED = PROC_REF(on_magic_unlock),
	)
	AddElement(/datum/element/connect_loc, loc_connections)

/obj/structure/window/openclose/Destroy()
	GLOB.TodUpdate -= src
	return ..()

/obj/structure/window/openclose/proc/on_magic_unlock(datum/source, datum/action/cooldown/spell/aoe/knock, mob/living/caster)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, PROC_REF(open_up))

/obj/structure/window/openclose/update_tod(todd)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/window/openclose/update_icon_state()
	. = ..()
	var/icon
	if(GLOB.tod == "night")
		icon += "w-"
	icon += initial(icon_state)
	if(brokenstate)
		icon_state = "[icon]br"
		return
	if(climbable)
		icon_state = "[icon]op"
		return
	icon_state = "[icon]"

/obj/structure/window/openclose/attack_hand_secondary(mob/user, params)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(get_dir(src, user) == lockdir)
		if(brokenstate)
			to_chat(user, "<span class='warning'>It's broken, that would be foolish.</span>")
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
		if(climbable)
			close_up(user)
		else
			open_up(user)
	else
		to_chat(user, "<span class='warning'>The window doesn't close from this side.</span>")

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/window/openclose/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/weapon/knife/dagger) && !climbable && !user.cmode)
		to_chat(user, span_notice("I start trying to pry the window open..."))
		if(do_after(user, 6 SECONDS, src))
			playsound(src, 'sound/foley/doors/windowup.ogg', 100, FALSE)
			src.force_open()
	else
		return ..()

/obj/structure/window/openclose/reinforced
	desc = "A glass window. This one looks reinforced with a metal mesh."
	icon_state = MAP_SWITCH("reinforcedwindow", "reinforcedwindowdir")
	max_integrity = 800
	integrity_failure = 0.1
	metalizer_result = null
	smeltresult = /obj/item/ingot/iron

/obj/structure/window/proc/open_up(mob/user)
	if(user)
		visible_message("<span class='info'>[user] opens [src].</span>")
	playsound(src, 'sound/foley/doors/windowup.ogg', 100, FALSE)
	climbable = TRUE
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/window/proc/close_up(mob/user)
	if(user)
		visible_message("<span class='info'>[user] closes [src].</span>")
	playsound(src, 'sound/foley/doors/windowdown.ogg', 100, FALSE)
	climbable = FALSE
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/window/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(mover.throwing && !climbable)
		if(isliving(mover))
			if(iscarbon(mover))
				var/mob/living/carbon/dude = mover
				take_damage(20 * (dude.STASTR / 10))
			else
				take_damage(10)
		else if(isitem(mover) && mover.throwforce > 10)
			take_damage(mover.throwforce)

	if(climbable && (mover.throwing || mover.movement_type & (FLYING|FLOATING)))
		if(ishuman(mover))
			var/mob/living/carbon/human/dude = mover
			var/is_jumping = dude.has_status_effect(/datum/status_effect/is_jumping)
			if(prob(100 - clamp((dude.get_skill_level(/datum/skill/misc/athletics) + dude.get_skill_level(/datum/skill/misc/climbing)) * 10 - (!is_jumping * 30), 10, 100)))
				var/obj/item/bodypart/head/head = dude.get_bodypart(BODY_ZONE_HEAD)
				if(head)
					head.receive_damage(20)
				dude.Stun(5 SECONDS)
				dude.Knockdown(5 SECONDS)
				dude.add_stress(/datum/stressevent/hithead)
				dude.visible_message(
					span_warning("[dude] hits their head as they fly through the window!"),
					span_danger("I hit my head on the window frame!"),
				)

		return TRUE

/obj/structure/window/proc/force_open()
	playsound(src, 'sound/foley/doors/windowup.ogg', 100, FALSE)
	climbable = TRUE
	opacity = FALSE
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/window/attackby(obj/item/W, mob/user, params)
	return ..()

/obj/structure/window/attack_paw(mob/living/user)
	attack_hand(user)

/obj/structure/window/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(brokenstate)
		return
	if( user.used_intent.type == /datum/intent/unarmed/claw )
		to_chat(user, "<span class='warning'>[user] smashes the window!!</span>")
		obj_break()
		return
	user.changeNext_move(CLICK_CD_MELEE)
	src.visible_message("<span class='info'>[user] knocks on [src].</span>")
	add_fingerprint(user)
	playsound(src, 'sound/misc/glassknock.ogg', 100)


/obj/structure/window/obj_break(damage_flag, silent)
	if(!brokenstate)
		attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
		new /obj/item/natural/glass/shard (get_turf(src))
		climbable = TRUE
		brokenstate = TRUE
	update_appearance(UPDATE_ICON_STATE)
	..()
