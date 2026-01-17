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
			target.visible_message(span_warning("[target] glows with a forge's heat for a moment."))
			target.update_integrity(target.max_integrity, TRUE, null) //repair the actual integrity

//REVITALISE - refill energy to keep working
/datum/god_ritual/revitalize_malum
	name = "Revitalise"
	ritual_patron = /datum/patron/divine/malum
	incantations = list(
		"MALUM! We call on you!" = 3 SECONDS,
		"Let this devoted work longer!" = 3 SECONDS,
		"Bless them with your dedication!!" = 3 SECONDS,
	)

/datum/god_ritual/revitalize_malum/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		if(!target)
			return
		target.adjust_energy(target.max_energy)
		target.visible_message(span_noticesmall("[target] shakes out their hands. Time to work."), span_noticesmall("I feel refreshed and ready to work."))

