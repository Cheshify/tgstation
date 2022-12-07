//Just some alt-uniforms themed around Star Trek - Pls don't sue, Mr Roddenberry ;_;

/obj/item/clothing/under/trek
	can_adjust = FALSE
	icon = 'icons/obj/clothing/under/trek.dmi'
	worn_icon = 'icons/mob/clothing/under/trek.dmi'
	greyscale_config = /datum/greyscale_config/trek
	greyscale_config_worn = /datum/greyscale_config/trek/worn

/*
*	The Original Series (Technically not THE original because these have a black undershirt while the very-original didn't but IDC)
*/
/obj/item/clothing/under/trek/command
	name = "command uniform"
	desc = "An outdated uniform worn by command officers."
	icon_state = "trek_tos_com" //Shirt has gold wrist-bands
	inhand_icon_state = "y_suit"
	greyscale_colors = "#fab342"

/obj/item/clothing/under/trek/engsec
	name = "engsec uniform"
	desc = "An outdated uniform worn by engineering/security officers."
	icon_state = "trek_tos_sec" //Tucked-in shirt
	inhand_icon_state = "r_suit"
	greyscale_colors = "#B72B2F"

/obj/item/clothing/under/trek/medsci
	name = "medsci uniform"
	desc = "An outdated uniform worn by medical/science officers."
	icon_state = "trek_tos"
	inhand_icon_state = "b_suit"
	greyscale_colors = "#5FA4CC"

/obj/item/clothing/under/trek/srvcar
	name = "service uniform"
	desc = "An outdated uniform worn by service and supply staff."
	icon_state = "trek_tos"
	inhand_icon_state = "g_suit"
	greyscale_colors = "#9FED58"

/obj/item/clothing/under/trek/assistant
	name = "assistant uniform"
	desc = "An outdated uniform worn by ship assistants."
	icon_state = "trek_tos"
	inhand_icon_state = "gy_suit"
	greyscale_colors = "#818181"

/*
*	The Next Generation
*/
/obj/item/clothing/under/trek/command/next
	icon_state = "trek_next" //Technically TNG had Command wearing red, but bc gold is closer to command roles for SS13 we're taking some liberties

/obj/item/clothing/under/trek/engsec/next
	icon_state = "trek_next"

/obj/item/clothing/under/trek/medsci/next
	icon_state = "trek_next"

/obj/item/clothing/under/trek/srvcar/next
	icon_state = "trek_next"

/obj/item/clothing/under/trek/assistant/next
	icon_state = "trek_next"

/*
*	Voyager
*/
/obj/item/clothing/under/trek/command/voy
	icon_state = "trek_voy" //Same point applies as TNG

/obj/item/clothing/under/trek/engsec/voy
	icon_state = "trek_voy"

/obj/item/clothing/under/trek/medsci/voy
	icon_state = "trek_voy"

/obj/item/clothing/under/trek/srvcar/voy
	icon_state = "trek_voy"

/obj/item/clothing/under/trek/assistant/voy
	icon_state = "trek_voy"

/*
*	Enterprise
*/
/obj/item/clothing/under/trek/command/ent
	icon_state = "trek_ent"
	//Greyscale sprite note, the base of it can't be greyscaled lest I make a whole new .json, but the color bands are greyscale at least.
	//I've left a greyscale version of it in color.dmi in case someone wants a pocketed-jumpsuit/'coveralls' without the color bands - Orion_the_Fox
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/trek/engsec/ent
	icon_state = "trek_ent"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/trek/medsci/ent
	icon_state = "trek_ent"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/trek/srvcar/ent
	icon_state = "trek_ent"
	inhand_icon_state = "bl_suit"

/obj/item/clothing/under/trek/assistant/ent
	icon_state = "trek_ent"
	inhand_icon_state = "bl_suit"

//Q
/obj/item/clothing/under/trek/q
	name = "french marshall's uniform"
	desc = "Something about this uniform feels off..."
	icon_state = "trek_Q"
	inhand_icon_state = "r_suit"
