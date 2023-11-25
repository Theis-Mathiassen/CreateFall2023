extends CharacterBody2D


@export var health = 5
@export var max_speed = 20
@export var acceleration = 15
@export var friction = 700
@export var player : Node2D

@onready var drink = $Whiskey

var player_chase = false
var player_seen = false

var player_in_attack_range = false

func _physics_process(delta):
	var dir = player.position - position
	
	if player_chase and player_seen:
		velocity += dir*acceleration
		velocity = velocity.limit_length(max_speed)
		
		$AnimatedSprite2D.play("moving")
	#else: 
		#if player_seen:
		#	$AnimatedSprite2D.play("idle2")
		#else:
		#	$AnimatedSprite2D.play("idle1")
	
	move_and_slide()
	


func _on_detection_area_body_entered(body):
	player_chase = true
	drink.play()
	if player_seen == false :
		$AnimatedSprite2D.play("idle2")
		await get_tree().create_timer(1).timeout
	player_seen = true


func _on_detection_area_body_exited(body):
	player_chase = false 
	velocity = Vector2.ZERO

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player") : 
		player_in_attack_range = true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player") : 
		player_in_attack_range = false
		
func deal_damage() :
	if player_in_attack_range and Global.player_current_attack == true :
		health = health - Global.attack_damage
func enemy():
	pass
