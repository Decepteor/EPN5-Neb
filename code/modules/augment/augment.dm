/obj/item/organ/internal/augment
	name = "embedded augment"
	desc = "Embedded augment."
	icon = 'icons/obj/augment.dmi'
	//By default these fit on both flesh and robotic organs and are robotic
	status = ORGAN_ROBOTIC
	var/augment_flags = AUGMENTATION_MECHANIC | AUGMENTATION_ORGANIC
	var/list/allowed_organs = list(BP_AUGMENT_R_ARM, BP_AUGMENT_L_ARM)
	default_action_type = /datum/action/item_action/organ/augment

/obj/item/organ/internal/augment/Initialize()
	..()
	organ_tag = pick(allowed_organs)
	update_parent_organ()

//General expectation is onInstall and onRemoved are overwritten to add effects to augmentee
/obj/item/organ/internal/augment/replaced(var/mob/living/carbon/human/target)
	if(..() && istype(owner))
		onInstall()

/obj/item/organ/internal/augment/proc/onInstall()


/obj/item/organ/internal/augment/removed(var/mob/living/user, var/drop_organ=1)
	onRemove()
	..()

/obj/item/organ/internal/augment/proc/onRemove()


/obj/item/organ/internal/augment/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(isScrewdriver(W) && allowed_organs.len > 1)
		//Here we can adjust location for implants that allow multiple slots
		organ_tag = input(user, "Adjust installation parameters") as null|anything in allowed_organs
		update_parent_organ()
		playsound(src.loc, 'sound/items/Screwdriver.ogg', 50, 1)
		return
	..()


/obj/item/organ/internal/augment/proc/update_parent_organ()
	//This tries to match a parent organ to an augment slot
	//This is intended to match the possible positions to a parent organ
	/
	//Update description
	desc = initial(desc)
	desc += " It is configured to be attached to the "
	if(organ_tag == BP_AUGMENT_L_LEG)
		parent_organ = BP_L_LEG
		desc += "left leg."
	if(organ_tag == BP_AUGMENT_R_LEG)
		parent_organ = BP_R_LEG
		desc += "right leg."
	if(organ_tag == BP_AUGMENT_L_HAND)
		parent_organ = BP_L_HAND
		desc += "left hand."
	if(organ_tag == BP_AUGMENT_R_HAND)
		parent_organ = BP_R_HAND
		desc += "right hand."
	if(organ_tag == BP_AUGMENT_L_ARM)
		parent_organ = BP_L_ARM
		desc += "left arm."
	if(organ_tag == BP_AUGMENT_R_ARM)
		parent_organ = BP_R_ARM
		desc += "right arm."
	if(organ_tag == BP_AUGMENT_HEAD)
		parent_organ = BP_HEAD
		desc += "head."
	if(organ_tag == BP_AUGMENT_CHEST_ACTIVE || organ_tag == BP_AUGMENT_CHEST_ARMOUR)
		parent_organ = BP_CHEST
		desc += "chest."