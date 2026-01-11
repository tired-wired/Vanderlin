/// An associative list of all the rituals a patron has.
GLOBAL_LIST_INIT(all_god_rituals, init_all_god_rituals())

/proc/init_all_god_rituals()
	var/list/all_god_rituals = list()
	for(var/ritual in typesof(/datum/god_ritual))
		var/datum/god_ritual/ritual_type = ritual
		LAZYADDASSOCLIST(all_god_rituals, initial(ritual_type.ritual_patron), ritual)
	return all_god_rituals


/datum/god_ritual
	abstract_type = /datum/god_ritual
	var/name = "Get Killed"

	/// the type of the patron used for the ritual.
	var/ritual_patron = /datum/patron/godless
	/// an associative list of incantations along with their delay. If you use emote invocation the string should be a list
	var/list/incantations = list(
		"FUCK YOU, ASTRATA!!" = 3 SECONDS,
		"GO FUCK YOURSELF!!" = 3 SECONDS,
	)
	var/invocation_type = INVOCATION_SHOUT

	var/mob/living/caster
	var/obj/structure/ritual_circle/sigil

/datum/god_ritual/New(mob/living/_caster, obj/structure/ritual_circle/_sigil)
	. = ..()
	caster = _caster
	sigil = _sigil

/datum/god_ritual/Destroy(force, ...)
	. = ..()
	if(sigil.active == src)
		sigil.active = null
		sigil.update_appearance(UPDATE_ICON_STATE)
	caster = null
	sigil = null

/datum/god_ritual/proc/start_ritual()
	if(QDELETED(caster) || QDELETED(sigil))
		qdel(src)
		return FALSE
	var/success = perform_ritual()
	on_completion(success)
	qdel(src)
	return success

//TODO: make sure these stop if you can't speak or whatever

/datum/god_ritual/proc/perform_ritual()
	var/index = 0
	for(var/incantation in incantations)
		index++
		if(!do_after(caster, incantations[incantation], sigil, display_over_user = TRUE))
			return FALSE
		recite_incantation(incantation, index)

/datum/god_ritual/proc/recite_incantation(message, index)
	switch(invocation_type)
		if(INVOCATION_SHOUT)
			caster.say(message, forced = "spell ([src])")
		if(INVOCATION_WHISPER)
			caster.whisper(message, forced = "spell ([src])")
		if(INVOCATION_EMOTE)
			caster.visible_message(
				capitalize(replace_pronouns(replacetext(message[1], "%CASTER", caster.name), caster)),
				capitalize(replace_pronouns(replacetext(message[2], "%CASTER", caster.name), caster)),
			)

/datum/god_ritual/proc/on_completion(success)
	return
