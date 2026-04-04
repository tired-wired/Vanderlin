/datum/action/cooldown/spell/undirected/eternal_vigilance
	name = "Eternal Vigilance"
	desc = "Enter a dreamless stasis. Close your eyes for a deeper trance."
	has_visual_effects = FALSE

	//so we don't accidentally give them arcane exp...
	associated_skill = /datum/attribute/skill/magic/holy

	//quick to get in and out.
	charge_required = FALSE
	cooldown_time = 3 SECONDS
	spell_cost = 0

	//tracking if we're already in stasis
	var/stasis = FALSE
	var/deep_stasis = FALSE


/datum/action/cooldown/spell/undirected/eternal_vigilance/cast(mob/living/carbon/human/cast_on)
	. = ..()
	if(stasis)
		//we're ALREADY in stasis, time to wake up
		REMOVE_TRAIT(cast_on, TRAIT_IMMOBILIZED, "species ability")
		stasis = FALSE
		cast_on.remove_status_effect(/datum/status_effect/stasis)
		if(deep_stasis)
			deep_stasis = FALSE
			//wake up!!
	else
		//try to enter stasis
		if(cast_on.eyesclosed)
			var/list/equipped_items = cast_on.get_equipped_items()
			for(var/obj/item/clothing/thing in equipped_items)
				if(thing.clothing_flags & CANT_SLEEP_IN)
					//we're too uncomfortable for deep stasis
					to_chat(src, span_boldwarning("I can't enter stasis...the [thing] bothers me..."))
					break
			//we made it through the items check, fall asleep standing
			ADD_TRAIT(cast_on, TRAIT_IMMOBILIZED, "species ability")
			stasis = TRUE
			deep_stasis = TRUE
			cast_on.apply_status_effect(/datum/status_effect/stasis)
			//TODO: make them eepy
		else
			//time for regular stasis
			ADD_TRAIT(cast_on, TRAIT_IMMOBILIZED, "species ability")
			cast_on.apply_status_effect(/datum/status_effect/stasis)
			stasis = TRUE
