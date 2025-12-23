/obj/structure/ritualcircle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/structure/ritualcircle/attack_hand_secondary(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] begins wiping away the rune"))
	if(do_after(user, 15))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

// This'll be our tutorial ritual for those who want to make more later, let's go into details in comments, mm? - Onutsio
/obj/structure/ritualcircle/astrata
	name = "Rune of the Sun" // defines name of the circle itself
	icon_state = "astrata_chalky" // the icon state, so, the sprite the runes use on the floor. As of making, we have 6, each needs an active/inactive state.
	desc = "A Holy Rune of Astrata" // description on examine
	var/solarrites = list("Guiding Light") // This is important - This is the var which stores every ritual option available to a ritualist - Ideally, we'd have like, 3 for each God. Right now, just 1.

/obj/structure/ritualcircle/astrata/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/astrata)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this...")) // You need ritualist to use them
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more.")) // If you have already done a ritual in the last 30 minutes, you cannot do another.
		return
	var/riteselection = input(user, "Rituals of the Sun", src) as null|anything in solarrites // When you use a open hand on a rune, It'll give you a selection of all the rites available from that rune
	switch(riteselection) // rite selection goes in this section, try to do something fluffy. Presentation is most important here, truthfully.
		if("Guiding Light") // User selects Guiding Light, begins the stuff for it
			if(!do_after(user, 50)) // just flavor stuff before activation
				return
			user.say("I beseech the Sun, Astrata!!")
			icon_state = "astrata_active"
			if(!do_after(user, 50))
				return
			user.say("To bring Order to a world of naught!!")
			if(!do_after(user, 50))
				return
			user.say("Place your gaze upon me, oh Radiant one!!")
			to_chat(user,span_danger("You feel the eye of Astrata turned upon you. Her warmth dances upon your cheek. You feel yourself warming up...")) // A bunch of flavor stuff, slow incanting.
			loc.visible_message(span_warning("[user]'s bursts to flames! Embraced by Her Warmth wholly!"))
			playsound(loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
			user.adjust_fire_stacks(10)
			user.IgniteMob()
			user.flash_fullscreen("redflash3")
			user.emote("firescream")
			guidinglight() // Actually starts the proc for applying the buff
			user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
			icon_state = "astrata_chalky"

/obj/structure/ritualcircle/astrata/proc/guidinglight()
	var/ritualtargets = view(7, loc) // Range of 7 from the source, which is the rune
	for(var/mob/living/carbon/human/target in ritualtargets) // defines the target as every human in this range
		target.apply_status_effect(/datum/status_effect/buff/guidinglight) // applies the status effect
		to_chat(target,span_cultsmall("Astrata's light guides me forward, drawn to me by the Ritualist's pyre!"))
		playsound(target, 'sound/magic/holyshield.ogg', 80, FALSE, -1) // Cool sound!
// If you want to review a more complicated one, Undermaiden's Bargain is probs the most complicated of the starting set. - Have fun! - Onutsio 🏳️‍⚧️

/obj/structure/ritualcircle/noc
	name = "Rune of the Moon"
	icon_state = "noc_chalky"
	desc = "A Holy Rune of Noc"
	var/lunarrites = list("Moonlight Dance") // list for more to be added later

/obj/structure/ritualcircle/noc/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/noc)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of the Moon", src) as null|anything in lunarrites
	switch(riteselection) // put ur rite selection here
		if("Moonlight Dance")
			if(!do_after(user, 50))
				return
			user.say("I beseech the God of Dreams!")
			icon_state = "noc_active"
			if(!do_after(user, 50))
				return
			user.say("To bring Wisdom to a world of naught!")
			if(!do_after(user, 50))
				return
			user.say("Place your gaze upon me, oh wise one!")
			to_chat(user,span_cultsmall("Noc bestows gifts only upon the worthy. With some effort, He may hear you."))
			playsound(loc, 'sound/magic/holyshield.ogg', 80, FALSE, -1)
			moonlightdance()
			user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)

/obj/structure/ritualcircle/noc/proc/moonlightdance()
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/moonlightdance)

/obj/structure/ritualcircle/xylix
	name = "Rune of Trickery"
	desc = "A Holy Rune of Xylix"

/obj/structure/ritualcircle/ravox
	name = "Rune of the Warrior"
	desc = "A Holy Rune of Ravox"

/obj/structure/ritualcircle/pestra
	name = "Rune of Plague"
	desc = "A Holy Rune of Pestra"
	icon_state = "pestra_chalky"
	var/plaguerites = list("Leechqueen's Triage")

/obj/structure/ritualcircle/pestra/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/pestra)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Plague", src) as null|anything in plaguerites
	switch(riteselection) // put ur rite selection here
		if("Leechqueen's Triage")
			if(!do_after(user, 50))
				return
			user.say("Well, you've gotten yourself in a bit of a scrape.")
			icon_state = "pestra_active"
			if(!do_after(user, 50))
				return
			user.say("Don't worry, we'll fix you right up.")
			if(!do_after(user, 50))
				return
			user.say("This might pinch a little, hold still...")
			//to_chat(user,span_danger("You feel something crawling up your throat, wriggling and slimy..."))
			if(!do_after(user, 30))
				return
			user.say("By Pestra's will, your pain fades!")
			to_chat(user,span_cultsmall("Their flesh writhes, their wounds knit shut! Beautiful!!"))
			//loc.visible_message(span_warning("[user] opens their mouth, disgorging a leech!"))
            //new /obj/item/natural/worms/leech(get_turf(C))
			leechqueenstriage()
			user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
			icon_state = "pestra_chalky"

/obj/structure/ritualcircle/pestra/proc/leechqueenstriage()
	var/ritualtargets = view(0, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		to_chat(target,span_userdanger("You feel your skin crawling, your flesh moving as it shouldn't!"))
		target.flash_fullscreen("redflash3")
		target.emote("agony")
		target.Stun(200)
		target.Knockdown(200)
		to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
		target.apply_status_effect(/datum/status_effect/buff/leechqueenstriage)

/obj/structure/ritualcircle/dendor
	name = "Rune of Beasts"
	desc = "A Holy Rune of Dendor"
	icon_state = "dendor_chalky"
	var/bestialrites = list("Rite of the Lesser Wolf")

/obj/structure/ritualcircle/dendor/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/dendor)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Beasts", src) as null|anything in bestialrites
	switch(riteselection) // put ur rite selection here
		if("Rite of the Lesser Wolf")
			if(!do_after(user, 50))
				return
			user.say("RRRGH GRRRHHHG GRRRRRHH!!")
			icon_state = "dendor_active"
			playsound(loc, 'sound/vo/mobs/vw/idle (1).ogg', 100, FALSE, -1)
			if(!do_after(user, 50))
				return
			user.say("GRRRR GRRRRHHHH!!")
			playsound(loc, 'sound/vo/mobs/vw/idle (4).ogg', 100, FALSE, -1)
			if(!do_after(user, 50))
				return
			loc.visible_message(span_warning("[user] snaps and snarls at the rune. Drool runs down their lip..."))
			playsound(loc, 'sound/vo/mobs/vw/bark (1).ogg', 100, FALSE, -1)
			if(!do_after(user, 30))
				return
			loc.visible_message(span_warning("[user] snaps their head upward, they let out a howl!"))
			playsound(loc, 'sound/vo/mobs/wwolf/howl (2).ogg', 100, FALSE, -1)
			lesserwolf()
			user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
			icon_state = "dendor_chalky"

/obj/structure/ritualcircle/dendor/proc/lesserwolf()
	var/ritualtargets = view(1, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/lesserwolf)


/obj/structure/ritualcircle/malum
	name = "Rune of Forge"
	desc = "A Holy Rune of Malum"

/obj/structure/ritualcircle/abyssor
	name = "Rune of Storm"
	desc = "A Holy Rune of Abyssor"

/obj/structure/ritualcircle/necra
	name = "Rune of Death"
	desc = "A Holy Rune of Necra"
	icon_state = "necra_chalky"
	//var/deathrites = list("Undermaiden's Bargain") commenting out until i ask for some advice

/obj/structure/ritualcircle/necra/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/necra)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Death", src) as null|anything in deathrites
	switch(riteselection) // put ur rite selection here
		if("Undermaiden's Bargain")
			loc.visible_message(span_warning("[user] sways before the rune, they open their mouth, though no words come out..."))
			icon_state = "necra_active"
			playsound(user, 'sound/vo/mobs/ghost/whisper (3).ogg', 100, FALSE, -1)
			if(!do_after(user, 60))
				return
			loc.visible_message(span_warning("[user] silently weeps, yet their tears do not flow..."))
			playsound(user, 'sound/vo/mobs/ghost/whisper (1).ogg', 100, FALSE, -1)
			if(!do_after(user, 60))
				return
			loc.visible_message(span_warning("[user] locks up, as though someone had just grabbed them..."))
			to_chat(user,span_danger("You feel cold breath on the back of your neck..."))
			playsound(user, 'sound/vo/mobs/ghost/death.ogg', 100, FALSE, -1)
			if(!do_after(user, 20))
				return
			user.say("Forgive me, the bargain is intoned!!")
			to_chat(user,span_cultsmall("My devotion to the Undermaiden has allowed me to strike a bargain for these souls...."))
			playsound(loc, 'sound/vo/mobs/ghost/moan (1).ogg', 100, FALSE, -1)
			undermaidenbargain()
			user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
			icon_state = "necra_chalky"

/obj/structure/ritualcircle/necra/proc/undermaidenbargain()
	var/ritualtargets = view(0, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/undermaidenbargain)


/obj/structure/ritualcircle/eora
	name = "Rune of Love"
	desc = "A Holy Rune of Eora"
	icon_state = "eora_chalky"

	var/peacerites = list("Rite of Pacification")

/obj/structure/ritualcircle/eora/attack_hand(mob/living/user)
	if((user.patron?.type) != /datum/patron/divine/eora)
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user,span_smallred("I don't know the proper rites for this..."))
		return
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user,span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return
	var/riteselection = input(user, "Rituals of Love", src) as null|anything in peacerites
	switch(riteselection) // put ur rite selection here
		if("Rite of Pacification")
			if(!do_after(user, 50))
				return
			user.say("#Blessed be your weary head...")
			icon_state = "eora_active"
			if(!do_after(user, 50))
				return
			user.say("#Full of strife and pain...")
			if(!do_after(user, 50))
				return
			user.say("#Let Her ease your fear...")
			if(!do_after(user, 50))
				return
			pacify()
			user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
			icon_state = "eora_chalky"

/obj/structure/ritualcircle/eora/proc/pacify()
	var/ritualtargets = view(0, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		loc.visible_message(span_warning("[target] sways like windchimes in the wind..."))
		target.visible_message(span_green("I feel the burdens of my heart lifting. Something feels very wrong... I don't mind at all..."))
		target.apply_status_effect(/datum/status_effect/buff/pacify)
