//BLESSING OF RECOVERY - heals the target on the sigil
/*
/datum/god_ritual/blessing_recovery
	name = "Blessing of Recovery"
	ritual_patron = /datum/patron/divine/pestra

/datum/god_ritual/blessing_recovery/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		if(!target)
			return
*/
//leper upon ye. with an upside
//grant the paintaker spell
