extends CharacterBody2D

@export var max_speed = 400
@export var friction = 1000
@export var acceleration = 2500

#@onready var animated_sprite_2d = $AnimatedSprite2D

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()
	
func player_movement(delta):
	# positive or negative 1 for x and y.
	input = get_input()
	
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

	
