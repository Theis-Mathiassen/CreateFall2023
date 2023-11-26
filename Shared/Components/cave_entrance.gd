extends Area2D


var touching_player: bool = false
var ready_to_enter: bool = false
@onready var timer = $"../Timer"

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	Global.recently_in_cave = true
	if ready_to_enter and touching_player and Input.is_action_just_released("Interact"):
		get_tree().change_scene_to_file("res://World/level_cave.tscn")
	#print(touching_player)



func _on_body_entered(body):
	touching_player = true


func _on_body_exited(body):
	touching_player = false


func _on_timer_timeout():
	ready_to_enter = true
	
	pass # Replace with function body.
