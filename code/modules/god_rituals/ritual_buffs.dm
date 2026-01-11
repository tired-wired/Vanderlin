//casting debuff
/datum/status_effect/debuff/ritual_exhaustion
	id = "ritual_exhaustion"
	duration = 5 MINUTES

/atom/movable/screen/alert/status_effect/debuff/ritual_exhaustion
	name = "Ritual Exhaustion"
	desc = "I've done a ritual too recently, I must rest."

//rite buffs for effects

//astrata
/datum/status_effect/buff/guiding_light
	//unfinished
	id = "guiding_light"
	effectedstats = list("perception" = 2)
	duration = 5 MINUTES

//noc
/datum/status_effect/buff/moonlight_visions
	id = "moonlight_visions"
	alert_type = /atom/movable/screen/alert/status_effect/buff/moonlight_visions
	effectedstats = list("intelligence" = 2)
	duration = 5 MINUTES

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
