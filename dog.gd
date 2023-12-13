extends enemy

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	health = 10
	attack_damage = 3
	attack_delay = 1
	max_speed = 15
	acceleration = 15
	friction = 700

func _physics_process(delta):
	#super(delta)
	var dir = (player.position + (player.velocity*1.5) - position)
	
	if player_chase :
		label.visible = true
		velocity += dir*acceleration
		velocity = velocity.limit_length(max_speed)
		
		if (velocity.x < 0):
			animated_sprite_2d.scale.x = 1
		else:
			animated_sprite_2d.scale.x = -1
		$AnimatedSprite2D.play("moving")
		
		if (player_in_attack_range):
			deal_damage()
			pass
	else: 
		label.visible = false
		$AnimatedSprite2D.play("idle")
	
	move_and_slide()
	take_damage()
	


func _on_detection_area_body_entered(body):
	player_chase = true

func _on_detection_area_body_exited(body):
	player_chase = false 
	velocity = Vector2.ZERO

func _on_enemy_hitbox_area_entered(area):
	if area.has_method("bullet") : 
		bullet_hit = true

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player") : 
		player_in_attack_range = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"): 
		$AnimatedSprite2D.play("idle1")
		player_in_attack_range = false

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func enemy():
	pass
