extends Node2D
@onready var canvas_modulate = $CanvasModulate
@onready var timer = $Timer
@onready var gameover = $Gameover
@onready var animation_player = $AnimationPlayer
@onready var button = $Button



# Called when the node enters the scene tree for the first time.
func _ready():
	button.visible = false
	

	animation_player.play("GameOver")
	
	

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await animation_player.animation_finished
	button.visible = true
	
	
	
	pass

		
	
	


func _on_button_button_down():
	print("down")
	
	Global.seconds = 10
	Global.minutes = 2
	Global.total_player_gold = 0
	Global.collected_since_quota = 0
	Global.stage_count = 1
	
	Global.gold_quota = 250
	Global.enemy_attack_damage = 1 * Global.stage_count
	
	Global.start_gold_count = 100
	Global.whiskey_drunk = false
	Global.bat_killed = false
	Global.player_position = Global.position.start
	
	
	Global.player_current_attack = false
	Global.player_health = 8
	Global.bullets = 10
	get_tree().change_scene_to_file("res://World/level2.tscn")
	pass # Replace with function body.


func _on_button_pressed():
	print("DOWN PRESSED!!!")
	pass # Replace with function body.
