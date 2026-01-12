//EORA'S PEACE - temporary pacification for a mood boost
/datum/god_ritual/eora_peace
	name = "Eora's Peace"
	ritual_patron = /datum/patron/divine/eora

/datum/god_ritual/mood_boost_eora/on_completion(success)
	. = ..()
	if(success)
		var/ritualtargets = view(0, sigil.loc)
		var/datum/status_effect/buff/eora_peace/pacify = /datum/status_effect/buff/eora_peace
		for(var/mob/living/carbon/human/target in ritualtargets)
			target.loc.visible_message(span_warning("[target] sways like windchimes in the wind..."))
			target.visible_message(span_green("I feel the burdens of my heart lifting. Something feels very wrong... I don't mind at all..."))
			target.apply_status_effect(pacify, initial(pacify.duration))
