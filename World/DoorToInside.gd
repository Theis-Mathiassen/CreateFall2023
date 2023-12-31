extends Area2D

var touching_player: bool
var ready_to_enter: bool = true
@onready var timer = $"../Timer"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(ready_to_enter)
	#print(touching_player)
	if ready_to_enter and touching_player and Input.is_action_just_released("Interact"):
		get_tree().change_scene_to_file("res://World/level2.tscn")
	#print(touching_player)
	pass


func _on_body_entered(body):
	touching_player = true
	
	pass # Replace with function body.


func _on_body_exited(body):
	touching_player = false
	pass # Replace with function body.


func _on_timer_timeout():
	ready_to_enter = true
	pass # Replace with function body.
