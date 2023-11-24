extends Area2D

@export var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	
	pass


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
