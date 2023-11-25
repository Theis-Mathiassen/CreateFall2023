extends StaticBody2D
@onready var animation_player = $AnimationPlayer
@onready var area_detection = %AreaDetection

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_area_2d_body_entered(body: Player):
	if body.mining:
		animation_player.play("Destroyed")
		print(body)
	pass # Replace with function body.


