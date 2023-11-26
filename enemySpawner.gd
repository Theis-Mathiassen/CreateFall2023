class_name Enemy_Spawner
extends Node2D



# Will track this player. This is such that it does not spawn enemies when player is near
@export var player: Node2D

@export var cooldown: int
#Used to count how many seconds have passed
var counter = 0

@export var enemy : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	if enemy == null:
		enemy = preload("res://Enemy.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _get_dist_to_player() -> int:
	var dist = abs($CollisionShape2D.global_position - player.global_position)
	return dist

func _on_timer_timeout():
	if(counter < cooldown):
		counter += 1
	else:
		#if (12 > 10): #Potential for no spawning if player is near
		var enemy_instance = enemy.instantiate()
		enemy_instance.player = player
		
		add_child(enemy_instance)
		
		
		counter = 0
	

