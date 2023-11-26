extends Area2D

var touching_player_2: bool
var ready_to_enter: bool = false
@onready var timer = $"../Timer"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.recently_in_cave = false
	print("Touching: " + str(touching_player_2))
	if ready_to_enter and touching_player_2 and Input.is_action_just_released("Interact"):
		get_tree().change_scene_to_file("res://World/level_outside.tscn")
	#print(touching_player)
	pass


func _on_body_entered(body):
	
	print("the body has entered!")
	touching_player_2 = true
	
	pass # Replace with function body.


func _on_body_exited(body):
	touching_player_2 = false
	pass # Replace with function body.


func _on_timer_timeout():
	ready_to_enter = true
	pass # Replace with function body.
