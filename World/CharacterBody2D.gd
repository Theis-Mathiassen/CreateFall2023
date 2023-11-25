class_name Player
extends CharacterBody2D

@export var max_speed = 150
@export var friction = 700
@export var acceleration = 2500
@onready var icon = $Icon

@onready var animation_player = $AnimationPlayer

#@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var marker_2d = $Marker2D
@onready var pickaxe_collision = %PickaxeCollision

var mining: bool = true

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var attack_cooldown = true
var player_alive = true


var input = Vector2.ZERO

var dynamite_equipped = true
var dynamite_off_cooldown = true
var dynamite = preload("res://Throwables/dynamite.tscn")


func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	
	if health <= 0 :
		player_alive = false 
		health = 0
		print("deadge")
		# end screen

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	return input.normalized()
	
func player_movement(delta):
	# positive or negative 1 for x and y.
	input = get_input()
	
	if input.x > 0.5:
		icon.scale.x = 1
		animation_player.play("Running")
	elif input.x < -0.5:
		icon.scale.x = -1
		animation_player.play("Running")
		
	elif input.y == 1:
		animation_player.play("RunningDown")
	elif input.y == -1:
		animation_player.play("RunningUp")
		
	else:
		if Input.is_action_pressed("Pickaxe"):
			mining = true
			animation_player.play("Pickaxe")
			pickaxe_collision.disabled = false
			
		else:
			mining = false
			animation_player.play("Idle")
		
		pickaxe_collision.disabled = true
	
	if Input.is_action_just_released("Pickaxe"):
		mining = false

	
	# Stops our character
	if input == Vector2.ZERO:
		if velocity.length() > (friction - delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			# Stop fully
			velocity  = Vector2.ZERO
			
	else:
		# speeds our character up
		velocity += (input * acceleration * delta)
		# stop at max speed
		velocity = velocity.limit_length(max_speed)
		
	move_and_slide()
	
	if Input.is_action_just_pressed("3"):
		if dynamite_equipped:
			dynamite_equipped = false
		else:
			dynamite_equipped = true
	
	var mouse_pos = get_global_mouse_position()
	marker_2d.look_at(mouse_pos)
	
	
	
	if Input.is_action_just_pressed("left_mouse") and dynamite_off_cooldown and dynamite_equipped:
		dynamite_off_cooldown = false
		var dynamite_instance = dynamite.instantiate()
		dynamite_instance.rotation = marker_2d.rotation
		dynamite_instance.global_position = marker_2d.global_position
		add_child(dynamite_instance)
		
		await get_tree().create_timer(0.4).timeout
		dynamite_off_cooldown = true


func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true


func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		Global.player_health = Global.player_health - 2
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(Global.player_health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


func player():
	pass
