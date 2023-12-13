extends enemy
@onready var animated_sprite_2d = $AnimatedSprite2D


func _ready():
	health = 8
	attack_damage = 2
	attack_delay = 1
	max_speed = 50
	acceleration = 15
	friction = 700

func _physics_process(delta):
	super(delta)
	
	if player_chase:
		$AnimatedSprite2D.play("moving")
	else: 
		$AnimatedSprite2D.play("idle1")
	
	


func _on_detection_area_body_entered(body):
	player_chase = true
	player_seen = true

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
