extends Node2D
@onready var player = $player
var door_position = Vector2(288.9951, 556.2836)
var hole_position = Vector2(342.2769, 581.6954)
@onready var whiskey = $Whiskey
@onready var bat = $bat
@onready var gold = $Gold
@onready var mine_label = $MineLabel
@onready var attack_label = $AttackLabel
@onready var whiskey_label = $WhiskeyLabel
@onready var interact_label = $InteractLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	if (Global.whiskey_drunk):
		whiskey.queue_free()
	if (Global.bat_killed):
		bat.queue_free()
	gold.count = Global.start_gold_count
	gold.decrease_gold_size(0)
	if Global.player_position == Global.position.cave:		
		player.global_position = hole_position
	if Global.player_position == Global.position.town:		
		player.global_position = door_position
	Global.player_position = Global.position.entrance
	if (Global.is_tutorial_complete()):
		mine_label.hide()
		attack_label.hide()
		whiskey_label.hide()
		interact_label.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (whiskey == null):
		Global.whiskey_drunk = true
	if (bat == null):
		Global.bat_killed = true
	if (gold != null):
		Global.start_gold_count = gold.count
