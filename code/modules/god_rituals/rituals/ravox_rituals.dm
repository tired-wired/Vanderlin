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
		to_chat(target,span_noticesmall("Ravox acknowledges your earnest plea. Your soul braces itself."))
		target?.visible_message(span_warning("[target] stands straighter and squares their shoulders."))
		target?.add_spell(/datum/action/cooldown/spell/undirected/list_target/ultimate_sacrifice)

//LAST STAND - trade [something] to avoid hardcrit.
/*/datum/god_ritual/last_stand
	name = "Last Stand"
	ritual_patron = /datum/patron/divine/ravox
*/
//antag check?
