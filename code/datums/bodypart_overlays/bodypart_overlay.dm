///Bodypart ovarlay datum. These can be added to any limb to give them a proper overlay, that'll even stay if the limb gets removed
///This is the abstract parent, don't use it!!
/datum/bodypart_overlay
<<<<<<< HEAD
	///Sometimes we need multiple layers, for like the back, middle and front of the person (EXTERNAL_FRONT, EXTERNAL_ADJACENT, EXTERNAL_BEHIND)
	var/layers
	///List of all possible layers. Used for looping through in drawing
	//var/static/list/all_layers = list(EXTERNAL_FRONT, EXTERNAL_ADJACENT, EXTERNAL_BEHIND) /// DOPPLER SHIFT REMOVAL
	/// DOPPLER SHIFT ADDITION BEGIN
	var/static/list/all_layers = list(
		EXTERNAL_FRONT,
		EXTERNAL_ADJACENT,
		EXTERNAL_ADJACENT_2,
		EXTERNAL_ADJACENT_3,
		EXTERNAL_BEHIND,
		EXTERNAL_HAND,
		EXTERNAL_BODY_FRONT_UNDER_CLOTHES,
	)
	/// DOPPLER SHIFT ADDITION END

	///Key of the icon states of all the sprite_datums for easy caching
	var/cache_key = ""

=======
	/**
	 * Assoc list [icon state postfix] to [layer of overlay].
	 *
	 * For simple overlays this will be a list of one element,
	 * but for more complicated overlays, this can be any number of component layers.
	 *
	 * Example:
	 * layers = list("front" = BODY_LAYER_FRONT) // - one layer, with icon state "[iconstate]_front"
	 * layers = list("adjacent" = BODY_LAYER_ADJACENT, "behind" = BODY_LAYER_BEHIND) // - two layers, one is "[iconstate]_adjacent", the other is "[iconstate]_behind"
	 * layers = list("layer1" = BODY_LAYER_ADJACENT, "layer2" = BODY_LAYER_BEHIND) // - two layers, with icon states "[iconstate]_layer1" and "[iconstate]_layer2"
	 * layers = list("" = BODY_LAYER_FRONT) // - one layer, with icon state "[iconstate]"
	 *
	 * This is cached, so be careful editing it at runtime (use the helpers!)
	 */
	VAR_PROTECTED/list/layers
>>>>>>> e7bc2fec00cb80b46430a38abca984960aa0da68
	/// Whether the overlay blocks emissive light
	var/blocks_emissive = EMISSIVE_BLOCK_UNIQUE
	/// Can this overlay be drawn on husked mobs?
	var/draw_on_husks = HUSK_OVERLAY_NONE
	/// Determines body area of the overlay for height offsets
	var/offset_location = NO_MODIFY

<<<<<<< HEAD
///Wrapper for getting the proper image, colored and everything
/datum/bodypart_overlay/proc/get_overlay(layer, obj/item/bodypart/limb)
	layer = bitflag_to_layer(layer)
	var/image/main_image = get_image(layer, limb)
	//DOPPLER EDIT START - Sets tails to be the transparency of their limb; mostly for slimepeople.
	if(limb)
		main_image.alpha = limb.alpha
	//DOPPLER EDIT END
	color_image(main_image, layer, limb)
	if(blocks_emissive == EMISSIVE_BLOCK_NONE || !limb)
		return main_image
=======
/datum/bodypart_overlay/New()
	. = ..()
	set_layers(layers)
>>>>>>> e7bc2fec00cb80b46430a38abca984960aa0da68

/// Used for adding a layer at runtime
/datum/bodypart_overlay/proc/set_layer(layer_postfix, layer_number)
	var/list/existing_layers = layers.Copy()
	existing_layers[layer_postfix] = layer_number
	layers = string_assoc_list(existing_layers)

/// Used for adding layers at runtime
/datum/bodypart_overlay/proc/set_layers(list/layer_list)
	if(!length(layer_list))
		return

	layers = string_assoc_list(layer_list)

/// Used for removing layers at runtime
/datum/bodypart_overlay/proc/clear_layer(layer_postfix)
	var/list/existing_layers = layers.Copy()
	existing_layers -= layer_postfix
	if(!length(existing_layers))
		layers = null
		return

	layers = string_assoc_list(existing_layers)

/**
 * Returns a list of overlays that this overlay datum draws
 *
 * * limb: the limb we're drawing onto
 *
 * Returns a list of images/mutable appearances
 */
/datum/bodypart_overlay/proc/get_all_overlays(obj/item/bodypart/limb)
	var/list/overlays = list()
	for(var/overlay_postfix, overlay_layer in layers)
		overlays += get_overlay(limb, overlay_postfix, -overlay_layer)
	return overlays

/**
 * Handles generating an individual overlay or an overlay + an emissive blocker
 *
 * * limb: the limb we're drawing onto, can be null if we're just drawing a general overlay for the mob and not a specific limb
 * * layer_index: the index of the layer we're drawing on, used for generating the image
 * * layer_real: the actual layer we're drawing on, used for generating the image
 *
 * Returns a list of images/mutable appearances, usually just one, but can be two if we need an emissive blocker
 */
/datum/bodypart_overlay/proc/get_overlay(obj/item/bodypart/limb, layer_index, layer_real)
	PROTECTED_PROC(TRUE)
	var/image/main_image = get_image(limb, layer_index, layer_real)

	if (limb?.is_husked && draw_on_husks != HUSK_OVERLAY_NORMAL)
		main_image = huskify_image(main_image, limb)
	else
		color_image(main_image, limb, layer_index)

	var/list/created_overlays = list(main_image)
	if(blocks_emissive != EMISSIVE_BLOCK_NONE && !isnull(limb))
		created_overlays += emissive_blocker(main_image.icon, main_image.icon_state, limb, layer = main_image.layer, alpha = main_image.alpha)

	return created_overlays

/// Helper to make an image look like a husk.
/// Returns the husk-ified image, doesn't modify the original image.
/datum/bodypart_overlay/proc/huskify_image(image/main_image, obj/item/bodypart/limb)
	PRIVATE_PROC(TRUE)
	var/icon/husk_icon = new(main_image.icon)
	husk_icon.ColorTone(HUSK_COLOR_TONE)
	main_image.icon = husk_icon
	main_image.color = limb.draw_color
	return main_image

/**
 * The actual proc where images / mutable appearances are generated for get_overlay
 * Must be implemented by subtypes, at its simplest it should just return an image
 *
 * * limb: the limb we're drawing onto, can be null if we're just drawing a general overlay for the mob and not a specific limb
 * * layer_index: the index of the layer we're drawing on.
 * Typically some postfix for an icon state ie. "front" or "behind" (Used like "overlay_front" or "overlay_behind"
 * * layer_real: the actual layer we're drawing on, used for generating the image.
 * Some (negative) number like -10 to -30. (Used like layer = layer_real, you shouldn't need to mess with it.)
 *
 * Returns an image/mutable appearance to draw on the mob.
 */
/datum/bodypart_overlay/proc/get_image(obj/item/bodypart/limb, layer_index, layer_real)
	CRASH("Get image needs to be overridden")

/**
 * Used to color the image, if necessary.
 * By default it does nothing.
 *
 * * image: the image generated by get_image() that we want to color
 * * limb: the limb we're drawing onto, can be null if we're just drawing a general overlay for the mob and not a specific limb.
 * * layer_index: the index of the layer we're drawing on, used for generating the image.
 */
/datum/bodypart_overlay/proc/color_image(image/overlay, obj/item/bodypart/limb, layer_index)
	return

/// Called on being added to a limb.
/datum/bodypart_overlay/proc/added_to_limb(obj/item/bodypart/limb)
	return

/// Called on being removed from a limb.
/datum/bodypart_overlay/proc/removed_from_limb(obj/item/bodypart/limb)
	return

/**
 * Used by subtypes to change the appearance of the overlay.
 * Typically implemented in tandem with a sprite accessory.
 */
/datum/bodypart_overlay/proc/set_appearance()
	CRASH("Update appearance needs to be overridden")

<<<<<<< HEAD
/**This exists so sprite accessories can still be per-layer without having to include that layer's
*  number in their sprite name, which causes issues when those numbers change.
*/
/datum/bodypart_overlay/proc/mutant_bodyparts_layertext(layer)
	switch(layer)
		if(-BODY_BEHIND_LAYER)
			return "BEHIND"
		if(-BODY_ADJ_LAYER)
			return "ADJ"
		if(-BODY_FRONT_LAYER)
			return "FRONT"
		/// DOPPLER SHIFT ADDITION BEGIN
		if(-BODY_ADJ_LAYER_2)
			return "ADJ_2"
		if(-BODY_ADJ_LAYER_3)
			return "ADJ_3"
		if(-BODY_HAND_LAYER)
			return "HAND"
		if (-BODY_FRONT_UNDER_CLOTHES_LAYER)
			return "FRONT_UNDER"
		/// DOPPLER SHIFT ADDITION END

///Converts a bitflag to the right layer. I'd love to make this a static index list, but byond made an attempt on my life when i did
/datum/bodypart_overlay/proc/bitflag_to_layer(layer)
	switch(layer)
		if(EXTERNAL_BEHIND)
			return -BODY_BEHIND_LAYER
		if(EXTERNAL_ADJACENT)
			return -BODY_ADJ_LAYER
		if(EXTERNAL_FRONT)
			return -BODY_FRONT_LAYER
		/// DOPPLER SHIFT ADDITION BEGIN
		if(EXTERNAL_ADJACENT_2)
			return -BODY_ADJ_LAYER_2
		if(EXTERNAL_ADJACENT_3)
			return -BODY_ADJ_LAYER_3
		if(EXTERNAL_HAND)
			return -BODY_HAND_LAYER
		if(EXTERNAL_BODY_FRONT_UNDER_CLOTHES)
			return -BODY_FRONT_UNDER_CLOTHES_LAYER
		/// DOPPLER SHIFT ADDITION END

///Check whether we can draw the overlays. You generally don't want lizard snouts to draw over an EVA suit
/datum/bodypart_overlay/proc/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner)
	return TRUE

///Colorizes the limb it's inserted to, if required.
/datum/bodypart_overlay/proc/override_color(obj/item/bodypart/bodypart_owner)
	CRASH("External organ color set to override with no override proc.")

///Generate a unique identifier to cache with. If you change something about the image, but the icon cache stays the same, it'll simply pull the unchanged image out of the cache
/datum/bodypart_overlay/proc/generate_icon_cache()
=======
/**
 * Checks whether the bodypart overlay can be drawn on the mob/bodypart.
 * Used so snouts are hidden by masks and whatnot.
 *
 * * bodypart_owner: the bodypart we're trying to draw on, will never be null.
 * * owner: the mob we're trying to draw on. Likely bodypart_owner.owner, can be null.
 *
 * Returns TRUE if we can draw
 * Returns FALSE if we can't draw
 */
/datum/bodypart_overlay/proc/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner)
	SHOULD_CALL_PARENT(TRUE)
	return !bodypart_owner.is_husked || draw_on_husks != HUSK_OVERLAY_NONE

/**
 * Used in human rendering to cache generated bodyparts.
 * Anything your bodypart overlay can change - such as color, icon state, etc - should be included in this,
 * otherwise you'll end up with caching issues where different looking overlays will share the same cache and thus look the same.
 *
 * * limb: the limb we're drawing onto, can be null if we're just drawing a general overlay for the mob and not a specific limb.
 *
 * Returns a list of strings/numbers/whatever that represents the unique appearance of the overlay.
 */
/datum/bodypart_overlay/proc/icon_render_key(obj/item/bodypart/limb)
>>>>>>> e7bc2fec00cb80b46430a38abca984960aa0da68
	return list()
