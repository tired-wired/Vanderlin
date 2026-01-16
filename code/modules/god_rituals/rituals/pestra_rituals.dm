//BLESSING OF RECOVERY - heals the target on the sigil
/datum/god_ritual/blessing_recovery
	name = "Blessing of Recovery"
	ritual_patron = /datum/patron/divine/pestra
	incantations = list(
		"Pestra, heal this wounded one!" = 3 SECONDS,
		"Help us aid them in recovery." = 3 SECONDS,
		"Heal! Writhe! Be rebuilt!" = 3 SECONDS,
	)

/datum/god_ritual/blessing_recovery/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		if(!target)
			return
		to_chat(caster,span_noticesmall("Their flesh writhes, their wounds knit shut! Beautiful!!"))
		target.emote("agony")
		to_chat(target,span_userdanger("You feel your skin crawling, your flesh moving as it shouldn't!"))
		target.heal_overall_damage(100, 100)

//PESTRA'S FAVOUR - temporary nopain
/datum/god_ritual/pestra_favour
	name = "Pestra's Favour"
	ritual_patron = /datum/patron/divine/pestra
	incantations = list(
		"Pestra, grant us Your gaze." = 3 SECONDS,
		"Let this soul endure the pain a while less." = 3 SECONDS,
		"Let them have respite." = 3 SECONDS,
	)

/datum/god_ritual/pestra_favour/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)
		if(!target)
			return
		target.apply_status_effect(/datum/status_effect/buff/pestra_favour, 15 MINUTES)

//grant the paintaker spell
