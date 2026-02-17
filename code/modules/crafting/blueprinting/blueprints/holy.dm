//ritual shrine itself
/datum/blueprint_recipe/structure/ritual_shrine
	name = "ritual shrine"
	result_type = /obj/structure/ritual_shrine
	required_materials = list(
		/obj/item/natural/stone = 2,
		/obj/item/natural/cloth = 1
	)
	verbage = "consecrate"
	verbage_tp = "consecrates"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = null
	requires_learning = TRUE
	construct_tool = null
