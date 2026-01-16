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
			target.visible_message(null, span_notice("My teeth itch, my eyes focus. Dendor's wilds run in me!"))

//SUMMON CREACHER - summon random chance of gote or saiga or mole
/datum/god_ritual/summon_creature
	name  = "Summon Creacher"
	ritual_patron = /datum/patron/divine/dendor
	cooldown = 30 MINUTES
	incantations = list(
		"I CALL THE BEASTS OF THE WILDS!" = 3 SECONDS,
		"MY COMPANIONS, MY COMRADES IN ARMS!" = 3 SECONDS,
		"Be my friend, please." = 3 SECONDS,
	)

/datum/god_ritual/summon_creature/on_completion(success)
	. = ..()
	if(success)
		sigil.visible_message("Vines unfurl from the rune. A beast emerges!")
		caster.apply_status_effect(/datum/status_effect/debuff/ritual_exhaustion, cooldown)
		var/list/summon_options = list(
			/mob/living/simple_animal/hostile/retaliate/goat = 15,
			/mob/living/simple_animal/hostile/retaliate/goatmale = 15,
			/mob/living/simple_animal/hostile/retaliate/saiga = 15,
			/mob/living/simple_animal/hostile/retaliate/saigabuck = 15,
			/mob/living/simple_animal/hostile/retaliate/mole = 15
		)
		var/mob/creature = pickweight(summon_options)
		var/summon_spot = get_turf(sigil)
		new creature(summon_spot)

//turn turfs into dirt/plants?
