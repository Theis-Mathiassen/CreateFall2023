extends Node2D
@onready var player = $player
var hole_position = Vector2(396.2769, 581.6954)
@onready var whiskey = $Whiskey
@onready var bat = $bat
@onready var gold = $Gold

# Called when the node enters the scene tree for the first time.
func _ready():
	if (Global.whiskey_drunk):
		whiskey.queue_free()
	if (Global.bat_killed):
		bat.queue_free()
	gold.count = Global.start_gold_count
	gold.decrease_gold_size(0)
	Global.is_in_cave = false
	print("IN CAVE?" + str(Global.recently_in_cave))
	if Global.recently_in_cave == true:		
		player.global_position = hole_position
		Global.recently_in_cave = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (whiskey == null):
		Global.whiskey_drunk = true
	if (bat == null):
		Global.bat_killed = true
	if (gold != null):
		Global.start_gold_count = gold.count
