//summon leviathan mob pet? 30 minute cooldown, item requirement?
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
		for(var/mob/living/target in range(2, sigil))
			target.blood_volume += BLOOD_VOLUME_OKAY

//summon fancy trident with items
