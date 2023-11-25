extends Area2D
@onready var audio_stream_player = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	audio_stream_player.play()
	
	Global.player_health += 2
	self.visible = false
	await audio_stream_player.finished
	queue_free()
	pass # Replace with function body.
