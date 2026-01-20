//casting debuff
/datum/status_effect/debuff/ritual_exhaustion
	id = "ritual_exhaustion"
	duration = 5 MINUTES
	status_type = STATUS_EFFECT_REPLACE

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
	status_type = STATUS_EFFECT_UNIQUE
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/guiding_light
	name = "Guiding Light"
	desc = "Astrata's light shows me the path."
	icon_state = "intelligence"

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
	status_type = STATUS_EFFECT_UNIQUE
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/moonlight_visions
	name = "Moonlight Visions"
	desc = "Noc's stony touch lay upon my mind, bringing me wisdom."
	icon_state = "intelligence"

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
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/buff/eora_peace
	name = "Eora's Peace"
	desc = "I feel my heart as light as feathers. All my worries have washed away."
	icon_state = "eora_bless"

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
	timer = 10 MINUTES
	stress_change = -5
	desc = span_green("All my problems have washed away!")

//dendor
/datum/status_effect/buff/lesser_wolf
	id = "lesser_wolf"
	alert_type = /atom/movable/screen/alert/status_effect/buff/lesser_wolf
	status_type = STATUS_EFFECT_UNIQUE
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/lesser_wolf
	name = "Lesser Wolf"
	desc = "Dendor runs with me!"
	icon_state = "bestialsense"

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

//pestra
/datum/status_effect/buff/pestra_favour
	id = "pestra_favour"
	alert_type = /atom/movable/screen/alert/status_effect/buff/pestra_favour
	status_type = STATUS_EFFECT_UNIQUE
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/pestra_favour
	name = "Pestra's Favour"
	desc = "The Leech-queen blesses me!"
	icon_state = "buff"

/datum/status_effect/buff/pestra_favour/on_apply()
	. = ..()
	to_chat(owner, span_warning("Pestra's gifts numb my skin."))
	ADD_TRAIT(owner, TRAIT_NOPAIN, "ritual")

/datum/status_effect/buff/pestra_favour/on_remove()
	. = ..()
	to_chat(owner, span_warning("The pain of the flesh rushes back in."))
	REMOVE_TRAIT(owner, TRAIT_NOPAIN, "ritual")

//xylix
/datum/status_effect/buff/masquerade
	id = "masquerade"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/buff/masquerade
	duration = 10 MINUTES

/atom/movable/screen/alert/status_effect/buff/masquerade
	name = "Masquerade"
	desc = "Xylix's mask covers my own."
	icon_state = "buff"

/datum/status_effect/buff/masquerade/on_apply()
	. = ..()
	to_chat(owner, span_noticesmall("Xylix laughs with me!"))
	owner.add_spell(/datum/action/cooldown/spell/mimicry/ritual)

/datum/status_effect/buff/masquerade/on_remove()
	. = ..()
	to_chat(owner, span_noticesmall("My mischief is over."))
	owner.remove_spell(/datum/action/cooldown/spell/mimicry/ritual)

//ravox
/datum/status_effect/buff/last_stand
	id = "last_stand"
	duration = 10 MINUTES
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/buff/last_stand

/atom/movable/screen/alert/status_effect/buff/last_stand
	name = "Last Stand"
	desc = "Ravox stands with me."
	icon_state = "ravox"

/datum/status_effect/buff/last_stand/on_apply()
	. = ..()
	to_chat(owner, "My blood rushes in my veins. Battle calls.")
	ADD_TRAIT(owner, TRAIT_NOSOFTCRIT, "ritual")
	ADD_TRAIT(owner, TRAIT_NOHARDCRIT, "ritual")

/datum/status_effect/buff/last_stand/on_remove()
	. = ..()
	to_chat(owner, "The adrenaline fades and leaves me empty.")
	REMOVE_TRAIT(owner, TRAIT_NOSOFTCRIT, "ritual")
	REMOVE_TRAIT(owner, TRAIT_NOHARDCRIT, "ritual")

//necra
/datum/status_effect/buff/make_time
	id = "make_time"
	duration = 2 MINUTES
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/buff/make_time

/atom/movable/screen/alert/status_effect/buff/make_time
	name = "Make Time"
	desc = "Necra turns Her gaze from me for a while."
	icon_state = "necravow"

/datum/status_effect/buff/make_time/tick()
	owner.adjustOxyLoss(-10)
	owner.blood_volume = max((BLOOD_VOLUME_SURVIVE * 1.5), owner.blood_volume)

/datum/status_effect/buff/make_time/on_apply()
	. = ..()
	to_chat(owner, "Necra's embrace feels further away.")
	ADD_TRAIT(owner, TRAIT_NODEATH, "ritual")

/datum/status_effect/buff/make_time/on_remove()
	. = ..()
	to_chat(owner, "My breath comes short once more.")
	REMOVE_TRAIT(owner, TRAIT_NODEATH, "ritual")

