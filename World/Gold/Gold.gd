extends StaticBody2D
@onready var animation_player = $AnimationPlayer
@onready var area_detection = %AreaDetection
var player : Player
var touched_by_player:bool = false
var Start_count = 100.0
var count = Start_count
@onready var original_scale = Vector2(%Sprite2D.scale.x, %Sprite2D.scale.y)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if player != null:
		if player.mining && touched_by_player:
			animation_player.play("Destroyed")
			var amount = Global.player_attack_damage * 20 * _delta
			decrease_gold_size(amount)
			Global.collect_gold(amount)
			if count <= 0:
				queue_free()




func _on_area_2d_body_entered(body: Player):
	player = body
	touched_by_player = true
	
	
	
		
func _on_area_2d_body_exited(_body):
	touched_by_player = false
	



func decrease_gold_size(amount):
	count -= amount
	%Sprite2D.scale = Vector2(original_scale.x*(count/Start_count), original_scale.y*(count/Start_count))




