extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Total gold:  " + str(Global.total_player_gold)
	pass


func _on_timer_timeout():
	Global
	pass # Replace with function body.
