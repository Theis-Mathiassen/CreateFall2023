extends enemy

@onready var animated_sprite_2d = $AnimatedSprite2D



func _physics_process(delta):
	super(delta)
	if player_chase and player_seen:
		label.visible = true
		animated_sprite_2d.play("moving")
	else:
		label.visible = false
		animated_sprite_2d.play("idle1")
		
	
	pass
	


func _on_detection_area_body_entered(body):
	player_chase = true
	if player_seen == false :
		animated_sprite_2d.play("idle1")
		await get_tree().create_timer(1).timeout
	player_seen = true


func _on_detection_area_body_exited(body):
	player_chase = false 
	velocity = Vector2.ZERO

func _on_enemy_hitbox_area_entered(area):
	print("Hit")
	if area.has_method("bullet") : 
		bullet_hit = true
		print("bullet = ", bullet_hit)

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player") : 
		player_in_attack_range = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"): 
		player_in_attack_range = false
		


func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func enemy():
	pass
