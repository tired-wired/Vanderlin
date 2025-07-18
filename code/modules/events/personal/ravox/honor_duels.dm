/datum/round_event_control/ravox_duel
	name = "Honor Duels"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/ravox_duel
	weight = 7
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 30

	tags = list(
		TAG_BATTLE,
	)

/datum/round_event_control/ravox_duel/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/ravox))
			continue
		return TRUE

	return FALSE

/datum/round_event/ravox_duel/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/ravox))
			continue
		valid_targets += human_mob

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/ravox_duel/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE RAVOX'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Ravox wants you to challenge others to honor duels! Win [new_objective.duels_required] duel\s to prove your worth! Duels end when a fighter yields or is knocked unconscious."))
	chosen_one.playsound_local(chosen_one, 'sound/vo/male/knight/rage (6).ogg', 70)

	chosen_one.mind.announce_personal_objectives()
