extends Node2D
@onready var player = $player
var hole_position = Vector2(396.2769, 581.6954)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("IN CAVE?" + str(Global.recently_in_cave))
	if Global.recently_in_cave == true:		
		player.global_position = hole_position
		Global.recently_in_cave = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
