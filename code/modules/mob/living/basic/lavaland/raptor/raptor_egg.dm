/obj/item/food/egg/raptor_egg
	name = "raptor egg"
	desc = "An uneven egg with a rough, thick shell."
	icon = 'icons/mob/simple/lavaland/raptor_baby.dmi'
	icon_state = "raptor_egg"
	resistance_flags = LAVA_PROOF|FIRE_PROOF
	/// Color typepath of the child we spawn
	var/datum/raptor_color/child_color = /datum/raptor_color
	/// Inheritance data to pass onto the child
	var/datum/raptor_inheritance/inherited_stats = null
	/// Current growth progress
	var/growth_progress = 0
	/// Minimum growth progress per second
	var/min_growth_rate = 0.8
	/// Maximum growth progress per second
	var/max_growth_rate = 1.2

/obj/item/food/egg/raptor_egg/Initialize(mapload)
	. = ..()
<<<<<<< HEAD
	if(SSmapping.current_map.minetype == MINETYPE_ICELAND || SSmapping.is_planetary()) // DOPPLER STATION EDIT, old code: if(SSmapping.is_planetary())
		icon = 'icons/mob/simple/lavaland/raptor_icebox.dmi'

/obj/item/food/egg/raptor_egg/proc/determine_growth_path(mob/living/basic/raptor/dad, mob/living/basic/raptor/mom)
	if(dad.type == mom.type)
		add_growth_component(dad.child_path)
		return
	var/dad_color = dad.raptor_color
	var/mom_color = mom.raptor_color
	var/list/my_colors = list(dad_color, mom_color)
	sortTim(my_colors, GLOBAL_PROC_REF(cmp_text_asc))
	for(var/path in GLOB.raptor_growth_paths) //guaranteed spawns
		var/list/required_colors = GLOB.raptor_growth_paths[path]
		if(!compare_list(my_colors, required_colors))
			continue
		add_growth_component(path)
		return
	var/list/valid_subtypesof = list()
	var/static/list/all_subtypes = subtypesof(/mob/living/basic/raptor/baby_raptor)
	for(var/path in all_subtypes)
		var/mob/living/basic/raptor/baby_raptor/raptor_path = path
		if(!prob(initial(raptor_path.roll_rate)))
			continue
		valid_subtypesof += raptor_path
	add_growth_component(pick(valid_subtypesof))

/obj/item/food/egg/raptor_egg/proc/add_growth_component(growth_path)
	if(length(GLOB.raptor_population) >= MAX_RAPTOR_POP)
		return
	AddComponent(\
		/datum/component/fertile_egg,\
		embryo_type = growth_path,\
		minimum_growth_rate = 0.5,\
		maximum_growth_rate = 1,\
		total_growth_required = 100,\
		current_growth = 0,\
		location_allowlist = typecacheof(list(/turf)),\
		post_hatch = CALLBACK(src, PROC_REF(post_hatch)),\
	)

/obj/item/food/egg/raptor_egg/proc/post_hatch(mob/living/basic/raptor/baby)
	if(!istype(baby))
		return
	QDEL_NULL(baby.inherited_stats)
	baby.inherited_stats = inherited_stats
	inherited_stats = null
=======
	AddElement(/datum/element/floor_placeable)
	START_PROCESSING(SSobj, src)
>>>>>>> e7bc2fec00cb80b46430a38abca984960aa0da68

/obj/item/food/egg/raptor_egg/Destroy()
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(inherited_stats)
	return ..()

/obj/item/food/egg/raptor_egg/examine(mob/user)
	. = ..()
	if (growth_progress >= RAPTOR_EGG_GROWTH_PROGRESS)
		. += span_boldnotice("Its noticeably shaking, ready to hatch!")

/obj/item/food/egg/raptor_egg/process(seconds_per_tick)
	if (!isturf(loc) || length(GLOB.raptor_population) >= MAX_RAPTOR_POP)
		return

	var/growth_value = rand(min_growth_rate, max_growth_rate) * seconds_per_tick * (1 + inherited_stats?.growth_modifier)
	// Slower growth off hot lavaland
	if (!SSmapping.level_trait(z, ZTRAIT_ASHSTORM))
		growth_value *= 0.75
	// Faster growth in hot hot lava
	if (islava(loc))
		growth_value *= 1.5

	growth_progress += growth_value
	// Don't hatch on lava though, or the chick will die instantly
	if (growth_progress < RAPTOR_EGG_GROWTH_PROGRESS || islava(loc))
		return

	visible_message(span_notice("[src] hatches with a quiet cracking sound."))
	new /mob/living/basic/raptor/baby(loc, child_color, inherited_stats)
	inherited_stats = null
	qdel(src)
