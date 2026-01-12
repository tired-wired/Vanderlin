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
		var/ritualtargets = view(0, sigil.loc)
		var/datum/action/cooldown/spell/undirected/list_target/ultimate_sacrifice/sacrifice_spell = /datum/action/cooldown/spell/undirected/list_target/ultimate_sacrifice
		for(var/mob/living/carbon/human/target in ritualtargets)
			to_chat(target,span_noticesmall("Ravox acknowledges your earnest plea. Your soul braces itself."))
			target.add_spell(sacrifice_spell)

//LAST STAND - trade [something] to avoid hardcrit.
/*/datum/god_ritual/last_stand
	name = "Last Stand"
	ritual_patron = /datum/patron/divine/ravox
*/
//antag check?
