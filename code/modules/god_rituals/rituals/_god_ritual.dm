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
	var/resistance_flag = MAGIC_RESISTANCE_HOLY
	/// This is the radius of the effect. 0 means only the tile it's on.
	var/cast_radius = 0
	var/ignore_caster = FALSE
	var/cooldown = 5 MINUTES
	var/list/required_atoms = list()
	// what types in the radius are targetted? leave null for override targetting.
	var/affected_type = /mob/living

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
	if(!QDELETED(sigil) && !QDELETED(caster))
		on_completion(success/*, get_targets(success)*/)
		qdel(src)
	return success

/datum/god_ritual/proc/perform_ritual()
	//check for item requirements. UNFINISHED.
	/*var/summon_spot = get_turf(sigil)
	for(var/obj/item/path as anything in required_atoms)
		var/amount_needed = required_atoms[path]
		if(!(requirement in summon_spot))
			to_chat(caster, span_noticesmall("I am missing [amount_needed] [requirement.name]!"))
			return FALSE
		else
			continue*/
	//all good, speak incantation
	var/index = 0
	for(var/incantation in incantations)
		index++
		if(!do_after(caster, incantations[incantation], sigil, display_over_user = TRUE))
			return FALSE
		recite_incantation(incantation, index)
	return TRUE

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

/datum/god_ritual/proc/on_completion(success/*, list/targets*/)
	if(success)
		caster.apply_status_effect(/datum/status_effect/debuff/ritual_exhaustion, cooldown)
	return

/*/datum/god_ritual/proc/get_targets(success)
	//TODO: option to find different targets on failure state
	var/list/targets = list()
	for(var/target in view(cast_radius, sigil))
		if(target == affected_type)
			targets += target
	if(ignore_caster)
		targets -= caster
	return targets*/

/*/datum/god_ritual/proc/check_holy_resistance(target)
	//check for resistance on the target, defaults to holy unless overridden in specific ritual
	if(target.can_block_magic(resistance_flag))
		return TRUE
	return FALSE*/

//the following is referenced from monke main's heretic codes
/*/datum/god_ritual/proc/cleanup_atoms(list/selected_atoms)
	SHOULD_CALL_PARENT(TRUE)

	for(var/atom/sacrificed as anything in selected_atoms)
		if(isliving(sacrificed))
			continue

		if(isstack(sacrificed))
			var/obj/item/stack/sac_stack = sacrificed
			var/how_much_to_use = 0
			for(var/requirement in required_atoms)
				// If it's not requirement type and type is not a list, skip over this check
				if(!istype(sacrificed, requirement) && !islist(requirement))
					continue
				// If requirement *is* a list and the stack *is* in the list, skip over this check
				if(islist(requirement) && !is_type_in_list(sacrificed, requirement))
					continue
				how_much_to_use = min(required_atoms[requirement], sac_stack.amount)
				break
			sac_stack.use(how_much_to_use)
			continue

		selected_atoms -= sacrificed
		qdel(sacrificed)*/
