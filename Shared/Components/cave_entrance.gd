extends Area2D


var touching_player: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(touching_player)


func _on_area_entered(area):
	touching_player = true


func _on_area_exited(area):
	touching_player = true
