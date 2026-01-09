/obj/structure/ritualcircle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/godrites = list() //empty list to assign one per rune
	var/patron_type_for_ritual = /datum/patron/divine/astrata

/obj/structure/ritualcircle/attack_hand_secondary(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] begins wiping away the rune."))
	if(do_after(user, 15))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

/obj/structure/ritualcircle/attack_hand(mob/living/carbon/human/user)
	//basic framework goes here

/obj/structure/ritualcircle/astrata
	name = "rune of the sun"
	desc = ""
	icon_state = "astrata_chalky"
	patron_type_for_ritual = /datum/patron/divine/astrata

/obj/structure/ritualcircle/noc
	name = "rune of the moon"
	desc = ""
	icon_state = "noc_chalky"
	patron_type_for_ritual = /datum/patron/divine/noc

/obj/structure/ritualcircle/abyssor
	name = "rune of the storm" //or seas, or blood, or tides
	desc = ""
	patron_type_for_ritual = /datum/patron/divine/abyssor
	//no icon available

/obj/structure/ritualcircle/dendor
	name = "rune of the wilds"
	desc = ""
	icon_state = "dendor_chalky"
	patron_type_for_ritual = /datum/patron/divine/dendor

/obj/structure/ritualcircle/malum
	name = "rune of creation" // or rune of the forge, maybe
	desc = ""
	icon_state = "malum_chalky"
	patron_type_for_ritual = /datum/patron/divine/malum

/obj/structure/ritualcircle/ravox
	name = "rune of the valiant" //placeholder
	desc = ""
	//no icon available
	patron_type_for_ritual = /datum/patron/divine/ravox

/obj/structure/ritualcircle/eora
	name = "rune of the heart"
	desc = ""
	icon_state = "eora_chalky"
	patron_type_for_ritual = /datum/patron/divine/eora


/obj/structure/ritualcircle/xylix
	name = "rune of the trickster" //or rune of the free?
	desc = ""
	//no icon available
	patron_type_for_ritual = /datum/patron/divine/xylix


/obj/structure/ritualcircle/necra
	name = "rune of the underworld"
	desc = ""
	icon_state = "necra_chalky"
	patron_type_for_ritual = /datum/patron/divine/necra

/obj/structure/ritualcircle/pestra
	name = "rune of medicine"
	desc = ""
	icon_state = "pestra_chalky"
	patron_type_for_ritual = /datum/patron/divine/pestra

/* Adding these in case they're used in the future.
/obj/structure/ritualcircle/zizo
	name = "rune of the lich" //placeholder
	desc = ""
	icon_state = "zizo_chalky"
	patron_type_for_ritual = /datum/patron/inhumen/zizo

/obj/structure/ritualcircle/baotha
	name = "rune of joy"
	desc = ""
	//no icon available
	patron_type_for_ritual = /datum/patron/inhumen/baotha

/obj/structure/ritualcircle/matthios
	name = "rune of thieves"
	desc = ""
	icon_state = "matthios_chalky"
	patron_type_for_ritual = /datum/patron/inhumen/matthios

/obj/structure/ritualcircle/graggar
	name = "rune of the warlord"
	desc = ""
	//no icon available
	patron_type_for_ritual = /datum/patron/inhumen/graggar
*/
