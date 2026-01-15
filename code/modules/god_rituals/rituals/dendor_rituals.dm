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
		for(var/mob/living/target in range(1, sigil))
			target.apply_status_effect(/datum/status_effect/buff/lesser_wolf)
			target.visible_message(span_notice("My teeth itch, my eyes focus. Dendor's wilds run in me!"))
//way of the wood - 'swim' through trees
//turn turfs into dirt?
//summon random chance of gote or saiga
