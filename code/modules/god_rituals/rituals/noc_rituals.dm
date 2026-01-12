//MOONLIGHT VISIONS - grants darkvision and +2 int. figure out source restrictions.
/datum/god_ritual/moonlight_visions
	name = "Moonlight Visions"
	ritual_patron = /datum/patron/divine/noc
	incantations = list (
		"Noc, bestow upon us Your wisdom." = 3 SECONDS,
		"Turn Your gaze to us!" = 3 SECONDS,
		"Aid us to discover the mysteries of Your weave!" = 3 SECONDS,
	)

/datum/god_ritual/moonlight_visions/on_completion(success)
	. = ..()
	if(success)
		for(var/mob/living/target in range(1, sigil))
			target.apply_status_effect(/datum/status_effect/buff/moonlight_visions)

//NOC'S LULLABY - makes you tired again
