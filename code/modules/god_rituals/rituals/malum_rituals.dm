//MALUM'S RENEWAL - repair a broken item
/datum/god_ritual/malum_renewal
	name = "Malum's Renewal"
	ritual_patron = /datum/patron/divine/malum
	incantations = list(
		"MALUM!!" = 3 SECONDS,
		"LET YOUR FORGE RENEW THIS OFFERING!!" = 3 SECONDS,
		"REPAIR IT SO WE MAY TOIL IN YOUR NAME!!" = 3 SECONDS,
	)

/datum/god_ritual/malum_renewal/on_completion(success)
	. = ..()
	if(success)
		var/counter = 0
		for(var/obj/item/target in range(1, sigil))
			if(counter == 2)
				return
			counter++
			target?.visible_message(span_warning("[target] glows with a forge's heat for a moment."))
			target?.update_integrity(target.max_integrity, TRUE, null) //repair the actual integrity

//refill fatigue/stamina
