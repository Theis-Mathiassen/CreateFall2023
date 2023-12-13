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
	if not Global.player_position == Global.position.cave:
		return
	if Global.seconds <= 0:
		if Global.minutes > 0:
			Global.seconds = 60
			Global.minutes -= 1
			
			
	if Global.minutes < 1 && (Global.collected_since_quota < Global.gold_quota || Global.player_position == Global.position.cave):
		warning.visible = true
	else:
		warning.visible = false
	
	if Global.minutes <= 0 and Global.seconds <= 0 and Global.player_position == Global.position.cave:
		Global.quota_end()
		
		
	
		
	
	Global.seconds -= 1
	if (Global.seconds <10):
		time.text = str(Global.minutes)+":0"+str(Global.seconds)
	else:
		time.text = str(Global.minutes)+":"+str(Global.seconds)
	pass # Replace with function body.
