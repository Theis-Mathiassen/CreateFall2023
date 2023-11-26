extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_ui ():
	if (Global.boots_upgrades >= Global.boots_upgrade_costs.size()-1):
		$Control/Cowboy_boots/Label.text = "Max upgraded"
	else:
		$Control/Cowboy_boots/Label.text = "Lvl " + str(Global.boots_upgrades + 2) + ": " + str(Global.boots_upgrade_costs[(Global.boots_upgrades + 1)]) + "$"
	if (Global.vest_upgrades >= Global.vest_upgrade_costs.size()-1):
		$Control/Cowboy_vest/Label.text = "Max upgraded"
	else:
		$Control/Cowboy_vest/Label.text = "Lvl " + str(Global.vest_upgrades + 2) + ": " + str(Global.vest_upgrade_costs[(Global.vest_upgrades + 1)]) + "$"
	if (Global.pick_upgrades >= Global.pick_upgrade_costs.size()-1):
		$Control/Goldminers_pick/Label.text = "Max upgraded"
	else:
		$Control/Goldminers_pick/Label.text = "Lvl " + str(Global.pick_upgrades + 2) + ": " + str(Global.pick_upgrade_costs[(Global.pick_upgrades + 1)]) + "$"
	if (Global.light_upgrades >= Global.light_upgrade_costs.size()-1):
		$Control/Fireflies/Label.text = "Max upgraded"
	else:
		$Control/Fireflies/Label.text = "Lvl " + str(Global.light_upgrades + 2) + ": " + str(Global.light_upgrade_costs[(Global.light_upgrades + 1)]) + "$"
	if (Global.gun_upgrades >= Global.gun_upgrade_costs.size()-1):
		$Control/Sturdier_gun/Label.text = "Max upgraded"
	else:
		$Control/Sturdier_gun/Label.text = "Lvl " + str(Global.gun_upgrades + 2) + ": " + str(Global.gun_upgrade_costs[(Global.gun_upgrades + 1)]) + "$"
	
	$Control/Bullets/Label.text = str(Global.bullet_cost) + "$"
	
	
	
func _on_cowboy_boots_pressed():
	Global.upgrade_boots()
	update_ui()


func _on_cowboy_vest_pressed():
	Global.upgrade_vest()
	update_ui()


func _on_goldminers_pick_pressed():
	Global.upgrade_pick()
	update_ui()


func _on_fireflies_pressed():
	Global.upgrade_light()
	update_ui()


func _on_bullets_pressed():
	Global.buy_bullets()
	update_ui()


func _on_sturdier_gun_pressed():
	Global.upgrade_gun()
	update_ui()


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://World/Town.tscn")
