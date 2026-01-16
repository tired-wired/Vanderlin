//MAXIMIZE LEECH - summons a dire leech. 30 minute cooldown, item requirement
/datum/god_ritual/maximize_leech
	name = "Maximize Leech"
	ritual_patron = /datum/patron/divine/abyssor
	cooldown = 30 MINUTES
	incantations = list(
		"Abyssor, we remember You!" = 3 SECONDS,
		"Send us a creature of Your domain." = 3 SECONDS,
		"To accompany and remind us of Your power." = 3 SECONDS,
	)

/datum/god_ritual/maximize_leech/on_completion(success)
	. = ..()
	if(success)
		//caster.apply_status_effect(/datum/status_effect/debuff/ritual_exhaustion, cooldown) this is for the real one
		var/summon_spot = get_turf(sigil)
		var/leech = /obj/item/natural/worms/leech
		new leech(summon_spot)
		sigil.visible_message("What? It's just a leech!?")

//BLOOD TRANSFUSION - Multitarget blood refill
/datum/god_ritual/blood_transfusion
	name = "Blood Transfusion"
	ritual_patron = /datum/patron/divine/abyssor
	incantations = list(
		"ABYSSOR! WE BESEECH YOU!" = 3 SECONDS,
		"GRANT US LIFE'S BLOOD!" = 3 SECONDS,
		"SAVE THE FAITHFUL!" = 3 SECONDS,
	)

/datum/god_ritual/blood_transfusion/on_completion(success)
	. = ..()
	if(success)
		sigil.visible_message("A wave of water rushes from the sigil before fading back into nothingness.")
		for(var/mob/living/target in range(2, sigil))
			target.blood_volume += BLOOD_VOLUME_OKAY

//summon fancy trident with items
