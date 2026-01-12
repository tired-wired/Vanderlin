//RITE OF THE LESSER WOLF - grants beast sense and strong bite
/datum/god_ritual/lesser_wolf
	name = "Rite of the Lesser Wolf"
	ritual_patron = /datum/patron/divine/dendor
	incantations = list(
		"DENDOR! HEAR US!!" = 3 SECONDS,
		"LET US BE ONE WITH YOUR WILL!!" = 3 SECONDS,
		"WE PROTECT YOUR WILDS!" = 3 SECONDS,
	)

/datum/god_ritual/lesser_wolf/on_completion(success)
	. = ..()
	if(success)
		var/ritualtargets = view(3, sigil.loc)
		var/datum/status_effect/buff/lesser_wolf/lesser_wolf_status = /datum/status_effect/buff/lesser_wolf
		for(var/mob/living/carbon/human/target in ritualtargets)
			target.apply_status_effect(lesser_wolf_status, initial(lesser_wolf_status.duration))
			target.visible_message(span_notice("My teeth itch, my eyes focus. Dendor's wilds run in me!"))

