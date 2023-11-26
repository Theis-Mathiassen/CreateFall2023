extends Node2D
@onready var canvas_modulate = $CanvasModulate
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	blink_game_over()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func blink_game_over():
	var blink_frequence = 0.2
	for i in range(50):
		blink_frequence -= 0.01
		await get_tree().create_timer(blink_frequence).timeout
		print("blink")
		canvas_modulate.visible = true
		
		
	
	
