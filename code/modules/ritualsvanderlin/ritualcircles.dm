/obj/structure/ritualcircle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	var/active_rune_state = "ritual_base"
	var/sleepy_rune_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/godrites = list()
	var/patron_type_for_ritual = /datum/patron/divine/astrata

/obj/structure/ritualcircle/attack_hand_secondary(mob/living/user)
	user.visible_message(span_warning("[user] begins wiping away the rune."))
	if(do_after(user, 15))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

/obj/structure/ritualcircle/attack_hand(mob/living/user)
	if(user.patron?.type != patron_type_for_ritual)
		user.visible_message(span_warning("I don't know this god's rites."))
		return
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		user.visible_message(span_warning("This is beyond my knowledge."))
		return
	var/riteselection = input(user, "Rituals of the Gods", src) as null|anything in godrites
	run_ritual(riteselection,user)

/obj/structure/ritualcircle/proc/run_ritual(god_ritual_requested,user)
	icon_state = active_rune_state
	do_after(user, 30, src)
	to_chat(user,span_smallred("I am doing something!!"))
	icon_state = sleepy_rune_state

//Circle structures below

/obj/structure/ritualcircle/astrata
	name = "rune of the sun"
	desc = ""
	icon_state = "astrata_chalky"
	sleepy_rune_state = "astrata_chalky"
	active_rune_state = "astrata_active"
	patron_type_for_ritual = /datum/patron/divine/astrata
	godrites = list("ritualexample")

/obj/structure/ritualcircle/noc
	name = "rune of the moon"
	desc = ""
	icon_state = "noc_chalky"
	sleepy_rune_state = "noc_chalky"
	active_rune_state = "noc_active"
	patron_type_for_ritual = /datum/patron/divine/noc

/obj/structure/ritualcircle/abyssor
	name = "rune of the storm" //or seas, or blood, or tides
	desc = ""
	patron_type_for_ritual = /datum/patron/divine/abyssor
	//icon_state = "abyssor_chalky"
	//sleepy_rune_state = "abyssor_chalky"
	//active_rune_state = "abyssor_active"

/obj/structure/ritualcircle/dendor
	name = "rune of the wilds"
	desc = ""
	icon_state = "dendor_chalky"
	sleepy_rune_state = "dendor_chalky"
	active_rune_state = "dendor_active"
	patron_type_for_ritual = /datum/patron/divine/dendor

/obj/structure/ritualcircle/malum
	name = "rune of creation" // or rune of the forge, maybe
	desc = ""
	icon_state = "malum_chalky"
	sleepy_rune_state = "malum_chalky"
	active_rune_state = "malum_active"
	patron_type_for_ritual = /datum/patron/divine/malum

/obj/structure/ritualcircle/ravox
	name = "rune of the valiant" //placeholder
	desc = ""
	//icon_state = "ravox_chalky"
	//sleepy_rune_state = "ravox_chalky"
	//active_rune_state = "ravox_active"
	patron_type_for_ritual = /datum/patron/divine/ravox

/obj/structure/ritualcircle/eora
	name = "rune of the heart"
	desc = ""
	icon_state = "eora_chalky"
	sleepy_rune_state = "eora_chalky"
	active_rune_state = "eora_active"
	patron_type_for_ritual = /datum/patron/divine/eora


/obj/structure/ritualcircle/xylix
	name = "rune of the trickster" //or rune of the free?
	desc = ""
	//icon_state = "xylix_chalky"
	//sleepy_rune_state = "xylix_chalky"
	//active_rune_state = "xylix_active"
	patron_type_for_ritual = /datum/patron/divine/xylix


/obj/structure/ritualcircle/necra
	name = "rune of the underworld"
	desc = ""
	icon_state = "necra_chalky"
	sleepy_rune_state = "necra_chalky"
	active_rune_state = "necra_active"
	patron_type_for_ritual = /datum/patron/divine/necra

/obj/structure/ritualcircle/pestra
	name = "rune of medicine" //open to change
	desc = ""
	icon_state = "pestra_chalky"
	sleepy_rune_state = "pestra_chalky"
	active_rune_state = "pestra_active"
	patron_type_for_ritual = /datum/patron/divine/pestra

/* Adding these in case they're used in the future.
/obj/structure/ritualcircle/zizo
	name = "rune of the lich" //placeholder
	desc = ""
	icon_state = "zizo_chalky"
	sleepy_rune_state = "zizo_chalky"
	active_rune_state = "zizo_active"
	patron_type_for_ritual = /datum/patron/inhumen/zizo

/obj/structure/ritualcircle/baotha
	name = "rune of joy"
	desc = ""
	icon_state = "baotha_chalky"
	sleepy_rune_state = "baotha_chalky"
	active_rune_state = "baotha_active"
	patron_type_for_ritual = /datum/patron/inhumen/baotha

/obj/structure/ritualcircle/matthios
	name = "rune of thieves"
	desc = ""
	icon_state = "matthios_chalky"
	sleepy_rune_state = "matthios_chalky"
	active_rune_state = "matthios_active"
	patron_type_for_ritual = /datum/patron/inhumen/matthios

/obj/structure/ritualcircle/graggar
	name = "rune of the warlord"
	desc = ""
	icon_state = "graggar_chalky"
	sleepy_rune_state = "graggar_chalky"
	active_rune_state = "graggar_active"
	patron_type_for_ritual = /datum/patron/inhumen/graggar
*/
