//MALUM'S RENEWAL - repair a broken item
/datum/god_ritual/malum_renewal
	name = "Malum's Renewal"
	ritual_patron = /datum/patron/divine/malum
	incantations = list(

	)

/datum/god_ritual/malum_renewal/on_completion(success)
	. = ..()
	if(success)
		var/ritualtargets = view(0, sigil.loc)
		var/counter = 0
		for(var/obj/item/target in ritualtargets)
			if(counter == 2)
				return
			counter++
			target.loc.visible_message(span_warning("[target] glows with a forge's heat for a moment."))
			target.atom_integrity = target.max_integrity //repair the actual integrity
			target.atom_fix() //make the sprite 'fixed'

//refill fatigue/stamina
