/datum/action/cooldown/spell/undirected/feather_falling
	name = "Feather Falling"
	desc = "Grant yourself and any creatures adjacent to you some defense against falls."
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_NO_MOVE
	button_icon_state = "jump"

	point_cost = 1

	charge_time = 4 SECONDS
	cooldown_time = 3 MINUTES
	spell_cost = 50
	spell_flags = SPELL_RITUOS
	attunements = list(
		/datum/attunement/aeromancy = 0.5,
	)

/datum/action/cooldown/spell/undirected/feather_falling/cast(atom/cast_on)
	. = ..()
	var/datum/status_effect/status = /datum/status_effect/buff/featherfall
	var/duration_increase = max(0, attuned_strength * 90 SECONDS)
	for(var/mob/living/L in viewers(max(1, FLOOR(attuned_strength, 1)), owner))
		L.apply_status_effect(status, initial(status.duration) + duration_increase)
