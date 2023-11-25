extends Area2D

var touching_player: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (touching_player && Input.is_action_pressed("Interact")):
		get_tree().change_scene_to_file("res://World/level2.tscn")
	#print(touching_player)


func _on_body_entered(body):
	print("Enter")
	touching_player = true

func _on_body_exited(body):
	print("Exit")
	touching_player = false



