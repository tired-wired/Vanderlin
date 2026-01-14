//EORA'S PEACE - temporary pacification for a mood boost
/datum/god_ritual/eora_peace
	name = "Eora's Peace"
	ritual_patron = /datum/patron/divine/eora
	incantations = list(
		"There's no need to be so worked up." = 3 SECONDS,
		"Just relax a while." = 3 SECONDS,
		"Let's talk it out." = 3 SECONDS,
	)

/datum/god_ritual/eora_peace/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		if(!target)
			return
		var/datum/status_effect/buff/eora_peace/pacify = /datum/status_effect/buff/eora_peace
		target.visible_message(span_warning("[target] sways like windchimes in the wind..."))
		target.visible_message(span_green("I feel the burdens of my heart lifting. Something feels very wrong... I don't mind at all..."))
		target.apply_status_effect(pacify, initial(pacify.duration))
