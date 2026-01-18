//PURGE UNDEAD - Blasts undead in a range. 30 minute cooldown, item requirement.
/datum/god_ritual/purge_undead
	name = "Purge Undead"
	ritual_patron = /datum/patron/divine/necra
	cooldown = 30 MINUTES
	incantations = list(
		"Accursed, defilers of the natural order!!" = 4 SECONDS,
		"Leave this place, protected by the Ten!!" = 4 SECONDS,
		"Flee the power of the Undermaiden!!!" = 4 SECONDS,
	)

/datum/god_ritual/purge_undead/on_completion(success)
	. = ..()
	if(success)
		caster.apply_status_effect(/datum/status_effect/debuff/ritual_exhaustion, cooldown)
		for(var/mob/living/carbon/victim in range(5,sigil))//1 tile larger than churn undead, but guaranteed to boom
			if(victim.mob_biotypes && MOB_UNDEAD)
				victim.visible_message(span_warning("[victim] HAS BEEN CHURNED BY NECRA'S GRIP!"), span_userdanger("I'VE BEEN CHURNED BY NECRA'S GRIP!"))
				explosion(get_turf(victim), light_impact_range = 1, flash_range = 1, smoke = FALSE)
				victim.throw_at(get_ranged_target_turf(victim, get_dir(sigil, victim), 4), 4, 1, victim, spin = FALSE)
				//Same as a lesser miracle direct
				victim.adjustFireLoss(30)
				victim.adjust_divine_fire_stacks(1)
				victim.IgniteMob()
				victim.Immobilize(5 SECONDS)

//MAKE TIME - Freeze all of a patient's current bloodloss for a while. (For stabilizing patients, not combat.)
/datum/god_ritual/make_time
	name = "Make Time"
	ritual_patron = /datum/patron/divine/necra
	incantations = list(
		"Necra, cast Your gaze aside;" = 3 SECONDS,
		"Let not this soul come to Your embrace." = 3 SECONDS,
		"Grant us time." = 3 SECONDS,
	)

/datum/god_ritual/make_time/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/human/target = locate(/mob/living/carbon/human) in get_turf(sigil)
		target.apply_status_effect(/datum/status_effect/buff/make_time)

//slow time in the vicinity, look at monke sandevistan
