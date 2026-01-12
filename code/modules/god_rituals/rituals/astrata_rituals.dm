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
		var/ritualtargets = view(3, sigil.loc)
		var/datum/status_effect/light_buff/light_buff_status = /datum/status_effect/light_buff
		var/datum/status_effect/buff/guiding_light/guiding_light_status = /datum/status_effect/buff/guiding_light
		for(var/mob/living/carbon/human/target in ritualtargets) // defines the target as every human in this range
			target.apply_status_effect(light_buff_status, initial(light_buff_status.duration), 7) // applies the status effect
			target.apply_status_effect(guiding_light_status, initial(guiding_light_status.duration))
			to_chat(target,span_noticesmall("Astrata's light guides me forward, drawn to me by the ritualist's prayer!"))
			playsound(target, 'sound/magic/holyshield.ogg', 80, FALSE, -1) // Cool sound!


//PHEONIX RITE - punishment/repentence, burns the target alive and heals them
/*
/datum/god_ritual/pheonix_cleanse
	name = "Phoenix Rite"
	ritual_patron = /datum/patron/divine/astrata
	incantations = list(
		"I am a placeholder!!" = 3 SECONDS,
	)

/datum/god_ritual/pheonix_cleanse/on_completion(success)
	. = ..()
	if(success)
		var/ritualtargets = view(0, sigil.loc)//only the person ON the sigil
		playsound(sigil.loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
		for(var/mob/living/carbon/human/target in ritualtargets)
			to_chat(target,span_danger("You feel the eye of Astrata turned upon you. Your soul shall be cleansed."))
			target.adjust_divine_fire_stacks(10)
			target.IgniteMob()
			target.loc.visible_message(span_warning("[target] bursts into flames, cleansed by Astrata!"))
			target.emote("firescream")
*/
