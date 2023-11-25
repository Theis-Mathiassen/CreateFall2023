extends CharacterBody2D


const SPEED = 300.0

# Will track this player
@export var player: Node2D

@onready var navAgent := $NavigationAgent2D as NavigationAgent2D



func _physics_process(_delta: float) -> void:
	var dir = to_local(navAgent.get_next_path_position()).normalized()
	velocity = dir * SPEED
	move_and_slide()

func make_path() -> void:
	navAgent.target_position = player.global_position


func _on_timer_timeout():
	make_path()
	

func enemy():
	pass

