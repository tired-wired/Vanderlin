//GUIDING_LIGHT - grants orison light and +2 per
/datum/god_ritual/guiding_light
	name = "Guiding Light"
	ritual_patron = /datum/patron/divine/astrata
	incantations = list(
		"I beseech the sun, Astrata!" = 3 SECONDS,
		"Turn Your gaze to us!" = 3 SECONDS,
		"Let Your light guide our path!" = 3 SECONDS,
	)

/datum/god_ritual/guiding_light/on_completion(success)
	. = ..()
	if(success)
		for(var/mob/living/target in range(1, sigil))
			target.apply_status_effect(/datum/status_effect/light_buff, 15 MINUTES, 7) // applies the status effect
			target.apply_status_effect(/datum/status_effect/buff/guiding_light)
			to_chat(target,span_noticesmall("Astrata's light guides me forward, drawn to me by the ritualist's prayer!"))
		playsound(sigil, 'sound/magic/holyshield.ogg', 80, FALSE, -1) // Cool sound!


//PHEONIX CLEANSING - punishment/repentence, burns the target alive
/datum/god_ritual/pheonix_cleanse
	name = "Phoenix Cleansing"
	ritual_patron = /datum/patron/divine/astrata
	incantations = list(
		"SINNER." = 3 SECONDS,
		"Astrata's fire will purge the evil from your soul." = 3 SECONDS,
		"Pray for Her mercy." = 3 SECONDS,
	)

/datum/god_ritual/pheonix_cleanse/on_completion(success)
	. = ..()
	if(success)
		var/mob/living/carbon/target = locate(/mob/living/carbon) in get_turf(sigil)//only the person ON the sigil
		if(!target)
			return
		playsound(sigil.loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
		target.adjust_divine_fire_stacks(30)
		target.IgniteMob()
		target.visible_message(span_warning("[target] bursts into flames, cleansed by Astrata!"), span_danger("You feel the eye of Astrata turned upon you. Your soul shall be cleansed!"))
		if(!HAS_TRAIT(target, TRAIT_NOPAIN))
			target.emote("firescream")
