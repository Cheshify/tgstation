
/datum/hud/ghost
	ui_style = 'icons/hud/screen_ghost.dmi'

/datum/hud/ghost/initialize_screen_objects()
	. = ..()
	add_screen_object(/atom/movable/screen/ghost/spawners_menu, HUD_GHOST_SPAWNERS)
	add_screen_object(/atom/movable/screen/ghost/orbit, HUD_GHOST_ORBIT)
	add_screen_object(/atom/movable/screen/ghost/reenter_corpse, HUD_GHOST_REENTER_CORPSE)
	add_screen_object(/atom/movable/screen/ghost/dnr, HUD_GHOST_DNR)
	add_screen_object(/atom/movable/screen/ghost/teleport, HUD_GHOST_TELEPORT)
	add_screen_object(/atom/movable/screen/ghost/settings, HUD_GHOST_SETTINGS)
	add_screen_object(/atom/movable/screen/ghost/minigames_menu, HUD_GHOST_MINIGAMES)
	add_screen_object(/atom/movable/screen/language_menu, HUD_MOB_LANGUAGE_MENU, HUD_GROUP_STATIC, ui_style, ui_ghost_language_menu)
	add_screen_object(/atom/movable/screen/floor_changer/vertical, HUD_MOB_FLOOR_CHANGER, HUD_GROUP_STATIC, ui_style, ui_ghost_floor_changer)

	var/list/hudboxes = valid_subtypesof(/atom/movable/screen/ghost/hudbox)
	for(var/i in 1 to length(hudboxes))
		add_screen_object(hudboxes[i], HUD_KEY_GHOST_HUDBOX(i), ui_loc = position_hudbox(i - 1))

<<<<<<< HEAD
/atom/movable/screen/ghost/spawners_menu/Click()
	var/mob/dead/observer/observer = usr
	observer.open_spawners_menu()

/atom/movable/screen/ghost/orbit
	name = "Orbit"
	icon_state = "orbit"

/atom/movable/screen/ghost/orbit/Click()
	GLOB.orbit_menu.show(usr)

/atom/movable/screen/ghost/reenter_corpse
	name = "Reenter corpse"
	icon_state = "reenter_corpse"

/atom/movable/screen/ghost/reenter_corpse/Click()
	var/mob/dead/observer/G = usr
	G.reenter_corpse()

/atom/movable/screen/ghost/dnr
	name = "Do Not Resuscitate"
	icon_state = "dnr"

/atom/movable/screen/ghost/dnr/Click()
	var/mob/dead/observer/dnring = usr
	dnring.do_not_resuscitate()

/atom/movable/screen/ghost/teleport
	name = "Teleport"
	icon_state = "teleport"

/atom/movable/screen/ghost/teleport/Click()
	var/mob/dead/observer/G = usr
	G.dead_tele()

/atom/movable/screen/ghost/settings
	name = "Ghost Settings"
	icon_state = "settings"

/atom/movable/screen/ghost/settings/MouseEntered(location, control, params)
	. = ..()
	flick(icon_state + "_anim", src)

/atom/movable/screen/ghost/settings/Click()
	GLOB.ghost_menu.ui_interact(usr)

/atom/movable/screen/ghost/minigames_menu
	name ="Minigames"
	icon_state = "minigames"

/atom/movable/screen/ghost/minigames_menu/Click()
	var/mob/dead/observer/observer = usr
	observer.open_minigames_menu()

/datum/hud/ghost/New(mob/owner)
	..()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/ghost/spawners_menu(null, src)
	using.screen_loc = ui_ghost_spawners_menu
	static_inventory += using

	using = new /atom/movable/screen/ghost/orbit(null, src)
	using.screen_loc = ui_ghost_orbit
	static_inventory += using

	using = new /atom/movable/screen/ghost/reenter_corpse(null, src)
	using.screen_loc = ui_ghost_reenter_corpse
	static_inventory += using

	using = new /atom/movable/screen/ghost/dnr(null, src)
	using.screen_loc = ui_dnr
	static_inventory += using

	using = new /atom/movable/screen/ghost/teleport(null, src)
	using.screen_loc = ui_ghost_teleport
	static_inventory += using

	using = new /atom/movable/screen/ghost/settings(null, src)
	using.screen_loc = ui_ghost_settings
	static_inventory += using

	using = new /atom/movable/screen/ghost/minigames_menu(null, src)
	using.screen_loc = ui_ghost_minigames
	static_inventory += using
	// DOPPLER EDIT ADDITION START - Soulcatcher button

	using = new /atom/movable/screen/ghost/join_soulcatcher(null, src)
	using.screen_loc = ui_ghost_soulcatcher
	static_inventory += using

	// DOPPLER EDIT ADDITION END

	using = new /atom/movable/screen/language_menu/ghost(null, src)
	using.screen_loc = ui_ghost_language_menu
	static_inventory += using

	floor_change = new /atom/movable/screen/floor_changer/vertical/ghost(null, src)
	floor_change.screen_loc = ui_ghost_floor_changer
	static_inventory += floor_change
=======
/datum/hud/ghost/proc/position_hudbox(i)
	var/row = floor(i / 3)
	var/column = i % 3
	return "SOUTH:[6 + row * 16], CENTER+5:[7 + column * 15]"
>>>>>>> e7bc2fec00cb80b46430a38abca984960aa0da68

/datum/hud/ghost/show_hud(version = 0, mob/viewmob)
	// don't show this HUD if observing; show the HUD of the observee
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		plane_masters_update()
		return FALSE

	. = ..()
	if(!.)
		return
	var/mob/screenmob = viewmob || mymob
	if(screenmob.client.prefs.read_preference(/datum/preference/toggle/ghost_hud))
		screenmob.client.screen |= screen_groups[HUD_GROUP_STATIC]
		for(var/atom/movable/screen/ghost/hudbox/hud in screen_groups[HUD_GROUP_STATIC])
			hud.update_appearance()
	else
		screenmob.client.screen -= screen_groups[HUD_GROUP_STATIC]

//We should only see observed mob alerts.
/datum/hud/ghost/reorganize_alerts(mob/viewmob)
	var/mob/dead/observer/O = mymob
	if (istype(O) && O.observetarget)
		return
	return ..()
