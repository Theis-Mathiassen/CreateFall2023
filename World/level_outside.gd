extends Node2D


var cave_entrance_position = Vector2(184, 66)
var shop_position = Vector2(-113.3334, 66)
@onready var player = $player


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.player_position == Global.position.entrance:		
		player.global_position = cave_entrance_position
	if Global.player_position == Global.position.shop:		
		player.global_position = shop_position
	Global.player_position = Global.position.town
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
