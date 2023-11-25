extends CanvasLayer
@onready var time = $Time
@onready var timer = $Timer
@onready var warning = $Warning




# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.seconds == 0 and Global.minutes == 0:
		Reset_Timer() 
	
	
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
	
	Global.seconds -= 1
	time.text = str(Global.minutes)+":"+str(Global.seconds)
	pass # Replace with function body.
