//casting debuff
/datum/status_effect/debuff/ritual_exhaustion
	id = "ritual_exhaustion"
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/ritual_exhaustion
	name = "Ritual Exhaustion"
	desc = "I've done a ritual too recently, I must rest."
	icon_state = "debuff"

//rite buffs for effects

//astrata
/datum/status_effect/buff/guiding_light
	id = "guiding_light"
	alert_type = /atom/movable/screen/alert/status_effect/buff/guiding_light
	effectedstats = list("perception" = 2)
	duration = 15 MINUTES

/atom/movable/screen/alert/status_effect/buff/guiding_light
	name = "Guiding Light"
	desc = "Astrata's light shows me the path."

/datum/status_effect/buff/guiding_light/on_apply()
	. = ..()
	to_chat(owner, span_noticesmall("Astrata's light warms me, I see the way."))

/datum/status_effect/buff/guiding_light/on_remove()
	. = ..()
	to_chat(owner, span_noticesmall("Astrata's light fades."))

//noc
/datum/status_effect/buff/moonlight_visions
	id = "moonlight_visions"
	alert_type = /atom/movable/screen/alert/status_effect/buff/moonlight_visions
	effectedstats = list("intelligence" = 2)
	duration = 15 MINUTES

/atom/movable/screen/alert/status_effect/buff/moonlight_visions
	name = "Moonlight Visions"
	desc = "Noc's stony touch lay upon my mind, bringing me wisdom."
	//icon_state = "moonlight_visions"

/datum/status_effect/buff/moonlight_visions/on_apply()
	. = ..()
	to_chat(owner, span_noticesmall("I see through the moonlight. Silvery threads dance in my vision."))
	ADD_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)

/datum/status_effect/buff/moonlight_visions/on_remove()
	. = ..()
	to_chat(owner, span_warning("Noc's silver leaves me."))
	REMOVE_TRAIT(owner, TRAIT_DARKVISION, MAGIC_TRAIT)

//eora
/datum/status_effect/buff/eora_peace
	id = "eora_peace"
	alert_type = /atom/movable/screen/alert/status_effect/buff/eora_peace
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/buff/eora_peace
	name = "Eora's Peace"
	desc = "I feel my heart as light as feathers. All my worries have washed away."
	icon_state = "buff"

/datum/status_effect/buff/eora_peace/on_apply()
	. = ..()
	to_chat(owner, span_green("Everything feels great!"))
	owner.add_stress(/datum/stress_event/pacified)
	ADD_TRAIT(owner, TRAIT_PACIFISM, TRAIT_GENERIC)

/datum/status_effect/buff/pacify/on_remove()
	. = ..()
	to_chat(owner, span_warning("My mind is my own again, no longer awash with foggy peace!"))
	REMOVE_TRAIT(owner, TRAIT_PACIFISM, TRAIT_GENERIC)

/datum/stress_event/pacified
	timer = 15 MINUTES
	stress_change = -5
	desc = span_green("All my problems have washed away!")

//dendor
/datum/status_effect/buff/lesser_wolf
	id = "lesser_wolf"
	alert_type = /atom/movable/screen/alert/status_effect/buff/lesser_wolf
	duration = 15 MINUTES

/atom/movable/screen/alert/status_effect/buff/lesser_wolf
	name = "Lesser Wolf"
	desc = "Dendor runs with me!"

/datum/status_effect/buff/lesser_wolf/on_apply()
	. = ..()
	to_chat(owner, span_green("The wilds call!"))
	ADD_TRAIT(owner, TRAIT_STRONGBITE, TRAIT_GENERIC)
	var/datum/status_effect/buff/beastsense/beastsense_status = /datum/status_effect/buff/beastsense
	owner.apply_status_effect(beastsense_status, initial(beastsense_status.duration))

/datum/status_effect/buff/lesser_wolf/on_remove()
	. = ..()
	to_chat(owner, span_warning("Dendor's senses leave me."))
	REMOVE_TRAIT(owner, TRAIT_STRONGBITE, TRAIT_GENERIC)

