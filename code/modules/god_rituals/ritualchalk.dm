/obj/item/ritualchalk
	name = "Ritual Chalk"
	icon_state = "chalk"
	desc = "Simple white blessed chalk. A useful tool for rites."
	icon = 'icons/roguetown/misc/rituals.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/ritualchalk/attack_self(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user, span_smallred("I don't know what I'm doing with this..."))
		return
	var/list/patrons_with_rites = list(
		/datum/patron/divine/astrata = /obj/structure/ritual_circle/astrata,\
		/datum/patron/divine/noc = /obj/structure/ritual_circle/noc,\
		/datum/patron/divine/dendor = /obj/structure/ritual_circle/dendor,\
		/datum/patron/divine/malum = /obj/structure/ritual_circle/malum,\
		/datum/patron/divine/xylix = /obj/structure/ritual_circle/xylix,\
		/datum/patron/divine/necra = /obj/structure/ritual_circle/necra,\
		/datum/patron/divine/pestra = /obj/structure/ritual_circle/pestra,\
		/datum/patron/divine/eora = /obj/structure/ritual_circle/eora,\
		/datum/patron/divine/ravox = /obj/structure/ritual_circle/ravox,\
		/datum/patron/divine/abyssor = /obj/structure/ritual_circle/abyssor,\
		/datum/patron/inhumen/zizo = /obj/structure/ritual_circle/zizo,\
		/datum/patron/inhumen/baotha = /obj/structure/ritual_circle/baotha,\
		/datum/patron/inhumen/matthios = /obj/structure/ritual_circle/matthios,\
		/datum/patron/inhumen/graggar = /obj/structure/ritual_circle/graggar
	)
	var/patron_to_use = user.patron?.type
	var/rune_to_use = patrons_with_rites[patron_to_use]
	to_chat(user,span_cultsmall("I begin inscribing the rune..."))
	if(do_after(user, 30, src))
		playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
		new rune_to_use(get_turf(user))

