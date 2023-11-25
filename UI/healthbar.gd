extends ProgressBar


func update_health():
	self.value = Global.player_health
	
	if Global.player_health >= 100:
		self.visible = false
	else:
		self.visible = true
		
	if Global.player_health < 0:
		Global.player_health = 0
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	update_health()
	pass
