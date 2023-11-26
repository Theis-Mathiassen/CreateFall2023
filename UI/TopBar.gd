extends CanvasLayer
@onready var time = $Time
@onready var timer = $Timer
@onready var warning = $Warning




# Called when the node enters the scene tree for the first time.
func _ready():

	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Reset_Timer():
	Global.seconds = Global.Dseconds
	Global.minutes = Global.DMinutes


func _on_timer_timeout():
	if Global.seconds == 0:
		if Global.minutes > 0:
			Global.seconds = 60
			Global.minutes -= 1
			
			
	if Global.minutes < 1:
		warning.visible = true
		
	if Global.minutes == 0 and Global.seconds == 0:
		if Global.total_player_gold < Global.gold_quota:
			get_tree().change_scene_to_file("res://World/GameOver.tscn")
		else:
			Global.total_player_gold -= Global.gold_quota
			Global.gold_quota *= 1.2
			Global.stage_count += 1
			Global.minutes = 2
			Global.seconds = 10
		
		
	
		
	
	Global.seconds -= 1
	time.text = str(Global.minutes)+":"+str(Global.seconds)
	pass # Replace with function body.
