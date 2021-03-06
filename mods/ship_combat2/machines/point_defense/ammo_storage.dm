/obj/machinery/point_defense/ammo_storage
	name = "point defense ammo storage"
	desc = "One of the centralized ammo storages for the ship's point defense mainframe."

	var/ammo = 0 //How much ammo we have
	var/max_ammo = 50
	var/obj/machinery/point_defense/point_defense_cannon/pdc //The point defense cannon we're linked to.
	var/orientation

/obj/machinery/point_defense/ammo_storage/on_update_icon()
	if(!icon_state)
		icon_state = "pdc_[orientation]"

	overlays.Cut()

	if(!ammo)
		overlays += image('mods/ship_combat2/icons/pointdefensemainframe.dmi', "pdc_ammo_[orientation]_empty")

	else if(ammo <= max_ammo * 0.25)
		overlays += image('mods/ship_combat2/icons/pointdefensemainframe.dmi', "pdc_ammo_[orientation]3")

	else if(ammo <= max_ammo * 0.50)
		overlays += image('mods/ship_combat2/icons/pointdefensemainframe.dmi', "pdc_ammo_[orientation]2")

	else if(ammo <= max_ammo * 0.75)
		overlays += image('mods/ship_combat2/icons/pointdefensemainframe.dmi', "pdc_ammo_[orientation]1")

	else if(ammo == 100)
		overlays += image('mods/ship_combat2/icons/pointdefensemainframe.dmi', "pdc_ammo_[orientation]")
		return

/obj/machinery/point_defense/ammo_storage/proc/remove_ammo(var/amount)
	if(ammo)
		ammo -= amount
	update_icon()

/obj/machinery/point_defense/ammo_storage/proc/can_remove_ammo(var/amount)
	if(ammo >= amount)
		return TRUE
	else
		return FALSE

/obj/machinery/point_defense/ammo_storage/left
	orientation = "left"

/obj/machinery/point_defense/ammo_storage/right
	orientation = "right"
