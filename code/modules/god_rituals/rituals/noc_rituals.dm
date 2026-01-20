//MOONLIGHT VISIONS - grants darkvision and +2 int
/datum/god_ritual/moonlight_visions
	name = "Moonlight Visions"
	ritual_patron = /datum/patron/divine/noc
	incantations = list(
		"Noc, bestow upon us Your wisdom." = 3 SECONDS,
		"Turn Your gaze to us!" = 3 SECONDS,
		"Aid us to discover the mysteries of Your weave!" = 3 SECONDS,
	)

/datum/god_ritual/moonlight_visions/on_completion(success)
	. = ..()
	if(success)
		for(var/mob/living/target in range(1, sigil))
			target.apply_status_effect(/datum/status_effect/buff/moonlight_visions)

//NOC'S LULLABY - makes you tired again
/datum/god_ritual/noc_lullaby
	name = "Noc's Lullaby"
	ritual_patron = /datum/patron/divine/noc
	cooldown = 30 MINUTES
	items_required = list(
		/obj/item/mana_battery/mana_crystal/small
	)
	incantations = list(
		"Noc, bless this soul with dreams." = 3 SECONDS,
		"Grant them Your holy rest." = 3 SECONDS,
		"Let them learn anew." = 3 SECONDS,
	)

/datum/god_ritual/noc_lullaby/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		if(!target)
			return
		to_chat(target, span_noticesmall("My eyelids grow heavy. Noc's dreams reach my mind."))
		target.apply_status_effect(/datum/status_effect/debuff/dreamytime)
		target.apply_status_effect(/datum/status_effect/debuff/sleepytime)

//two-way scrying. phone call?
