/obj/item/ritualchalk
	name = "Ritual Chalk"
	icon_state = "chalk"
	desc = "Simple white chalk. A useful tool for rites."
	icon = 'icons/roguetown/misc/rituals.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/ritualchalk/attack_self(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user, span_smallred("I don't know what I'm doing with this..."))
		return

	var/ritechoices = list()
	switch (user.patron?.type)
/*		if(/datum/patron/inhumen/zizo)
			ritechoices+="Rune of ZIZO" */
		if(/datum/patron/divine/astrata)
			ritechoices+="Rune of the Sun"
		if(/datum/patron/divine/noc)
			ritechoices+="Rune of the Moon"
		if(/datum/patron/divine/dendor)
			ritechoices+="Rune of the Wilds"
		if(/datum/patron/divine/malum)
			ritechoices+="Rune of Creation"
		if(/datum/patron/divine/xylix)
			ritechoices+="Rune of Trickery"
		if(/datum/patron/divine/necra)
			ritechoices+="Rune of the Underworld"
		if(/datum/patron/divine/pestra)
			ritechoices+="Rune of Medicine"
		if(/datum/patron/divine/eora)
			ritechoices+="Rune of the Heart"
		if(/datum/patron/divine/ravox)
			ritechoices+="Rune of the Valiant"
		if(/datum/patron/divine/abyssor)
			ritechoices+="Rune of the Storm"

	var/runeselection = input(user, "Which rune shall I inscribe?", src) as null|anything in ritechoices
	var/turf/step_turf = get_step(get_turf(user), user.dir)
	switch(runeselection)
		if("Rune of the Sun")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her radiance..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/astrata(step_turf)
		if("Rune of the Moon")
			to_chat(user, span_cultsmall("I begin inscribing the rune of His wisdom"))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/noc(step_turf)
		if("Rune of the Wilds")
			to_chat(user,span_cultsmall("I begin inscribing the rune of His madness"))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/dendor(step_turf)
		if("Rune of Creation")
			to_chat(user,span_cultsmall("I begin inscribing the rune of His craft..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/malum(step_turf)
		if("Rune of Trickery")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Their trickery..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/xylix(step_turf)
		if("Rune of the Underworld")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her embrace..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/necra(step_turf)
		if("Rune of Medicine")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her medicine..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/pestra(step_turf)
		if("Rune of the Heart")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her love..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/eora(step_turf)
		if("Rune of the Valiant")
			to_chat(user,span_cultsmall("I begin inscribing the rune of His prowess..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/ravox(step_turf)
		if("Rune of the Storm")
			to_chat(user,span_cultsmall("I begin inscribing the rune of His fury..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/abyssor(step_turf)
	/*	if("Rune of ZIZO")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Knowledge..."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/zizo(step_turf) */
