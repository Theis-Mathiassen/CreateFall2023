extends CharacterBody2D


@export var health = 8
@export var max_speed = 50
@export var acceleration = 15
@export var friction = 700
@export var player : Node2D


var player_chase = false
var can_take_damage = true
var bullet_hit = false

var player_in_attack_range = false


func _physics_process(delta):
	var dir = player.position - position
	
	if player_chase :
		velocity += dir*acceleration
		velocity = velocity.limit_length(max_speed)
		
		$AnimatedSprite2D.play("moving")
	#else: 
		#if player_seen:
		#	$AnimatedSprite2D.play("idle2")
		#else:
		#	$AnimatedSprite2D.play("idle1")
	
	move_and_slide()
	deal_damage()
	


func _on_detection_area_body_entered(body):
	player_chase = true

func _on_detection_area_body_exited(body):
	player_chase = false 
	velocity = Vector2.ZERO

func _on_enemy_hitbox_area_entered(area):
	if area.has_method("bullet") : 
		bullet_hit = true
		print("bullet = ", bullet_hit)

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player") : 
		player_in_attack_range = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"): 
		$AnimatedSprite2D.play("idle1")
		player_in_attack_range = false
		
func deal_damage() :
	if player_in_attack_range and Global.player_current_attack == true :
		if can_take_damage:
			health = health - Global.player_attack_damage
			$take_damage_cooldown.start()
			can_take_damage = false
			#print("Bat health = ", health)
			if health <= 0:
				self.queue_free()
	elif bullet_hit :
		if can_take_damage:
			health = health - Global.player_bullet_damage
			$take_damage_cooldown.start()
			can_take_damage = false
			bullet_hit = false
			print("Bat health = ", health)
			if health <= 0:
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true

func enemy():
	pass
