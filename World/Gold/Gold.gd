extends StaticBody2D
@onready var animation_player = $AnimationPlayer
@onready var area_detection = %AreaDetection

var count = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass





func _on_area_2d_body_entered(body: Player):

	
	while count > 0:
		if body.mining:
			await get_tree().create_timer(1.25).timeout
			animation_player.play("Destroyed")
			count -= 1
			decrease_gold_size()

	queue_free()
	
	
	
	print(body)
		
		
	pass # Replace with function body.
	



func decrease_gold_size():
	count -= 1
	Global.total_player_gold += 10
	self.scale = Vector2(scale.x - 0.1, scale.y - 0.1)
	pass # Replace with function body.
