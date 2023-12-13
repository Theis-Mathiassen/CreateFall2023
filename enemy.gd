extends CharacterBody2D
class_name enemy

const SPEED = 300.0

# Will track this player
@export var player: Player
@export var health: float = 4
@export var attack_damage: float = 1.0
@export var attack_delay: float = 1.0
@export var max_speed: float = 20.0
@export var acceleration: float = 15.0
@export var friction: float = 700.0

@onready var label = $Label
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D


var player_in_attack_range = false
var player_chase = false
var player_seen = false
var can_take_damage = true
var bullet_hit = false


func _ready():
	navAgent.target_position = player.position
	pass

func _physics_process(_delta: float) -> void:
	var dir = player.position - position
	
	if player_chase and player_seen:
		velocity += dir*acceleration
		velocity = velocity.limit_length(max_speed)
		
		
	move_and_slide()
	if (player_in_attack_range):
		print(player_in_attack_range)
		take_damage()
		deal_damage()
	#navAgent.set_target_position(player.position)
	#var next = navAgent.get_next_path_position()
	#var dir = to_local(next).normalized()
	#print(to_local(player.position))
	#velocity = dir * SPEED
	#move_and_slide()

func make_path() -> void:
	navAgent.target_position = player.global_position


func _on_timer_timeout():
	make_path()
	

func take_damage() :
	if Global.player_current_attack == true :
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
			#print("Bat health = ", health)
			if health <= 0:
				self.queue_free()

func deal_damage():
	player.enemy_attack(attack_damage)

func enemy():
	pass

