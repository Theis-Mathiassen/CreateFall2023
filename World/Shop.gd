extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_ui ():
	$Control/Cowboy_boots/Label.text = ""

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
