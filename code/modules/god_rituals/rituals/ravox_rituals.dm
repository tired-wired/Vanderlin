//VALIANT SACRIFICE - grant the ultimate sacrifice spell to the target.
/datum/god_ritual/valiant_sacrifice
	name = "Valiant Sacrifice"
	ritual_patron = /datum/patron/divine/ravox
	incantations = list(
		"Ravox, hear this soul's cry." = 3 SECONDS,
		"An injustice must be made right." = 3 SECONDS,
		"Grant this soul your valor!" = 3 SECONDS,
	)

/datum/god_ritual/valiant_sacrifice/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		target?.visible_message(span_warning("[target] stands straighter and squares their shoulders."), span_noticesmall("Ravox acknowledges your earnest plea. Your soul braces itself."))
		target?.add_spell(/datum/action/cooldown/spell/undirected/list_target/ultimate_sacrifice)

//LAST STAND - trade [something] to avoid hardcrit.
/datum/god_ritual/last_stand
	name = "Last Stand"
	ritual_patron = /datum/patron/divine/ravox

/datum/god_ritual/last_stand/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		if(!target)
			return
		target.apply_status_effect(/datum/status_effect/buff/last_stand)
		caster.apply_status_effect(/datum/status_effect/debuff/ritual_exhaustion, 30 MINUTES)

