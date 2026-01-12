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
		var/ritualtargets = view(3, sigil.loc)
		var/datum/status_effect/buff/moonlight_visions/moonlight_visions_status = /datum/status_effect/buff/moonlight_visions
		for(var/mob/living/carbon/human/target in ritualtargets)
			target.apply_status_effect(moonlight_visions_status, initial(moonlight_visions_status.duration))

//NOC'S MERCY - turns the target invisible
/*
/datum/god_ritual/noc_mercy
	name = "Noc's Mercy"
	ritual_patron = /datum/patron/divine/noc

/datum/god_ritual/noc_mercy/on_completion(success)
	. = ..()
	if(success)
		var/ritualtargets = view(0, sigil.loc)
		for(var/mob/living/carbon/human/target in ritualtargets)
			target.apply_status_effect(/datum/status_effect/invisibility, 3 MINUTES)
*/
