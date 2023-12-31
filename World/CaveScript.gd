extends Node2D
@onready
var tiles : TileMap = $Floor
@onready var player = $player
@onready var exit = $Cave_exits

var gold = preload("res://World/Gold/Gold.tscn")
var whiskey = preload("res://Shared/Components/whiskey.tscn")
var bat_spawner = preload("res://enemy_spawner.tscn")
var bat = preload("res://bat.tscn")
var dog = preload("res://dog.tscn")
var grip = preload("res://grip.tscn")



var border = 10
var map_size = Vector2i(84, 84)
var map_info = []
var room_index_map
var tile_size

var number_rooms = 0
var largest_room = 0
var tiles_in_rooms = []
var tiles_in_largest_room = []

# Instantiate
var noise
var altitude_noise_layer = {}
@export var noise_seed : int = 0
@export var alt_freq : float = 0.005
@export var oct : int = 4
@export var lac : int = 2
@export var gain : float = 0.5
@export var amplitude : float = 1.0

@export var cut_off : float = 0.8



var total_time = 0


# Variables for placing stuff in map
var entrance = Vector2i(0,0)
var number_gold = 7 + 7*0.2 * (Global.stage_count)
var number_bats = 20 + 20*0.2 * (Global.stage_count)
var number_dogs = 0 + 2 * max(Global.stage_count-1, 0)
var number_grips = 0 + 1 * max(Global.stage_count-3, 0)
var number_whiskey = 10 + 10*0.2 * (Global.stage_count)



# Called when the node enters the scene tree for the first time.
func _ready():
	tile_size = Vector2i(tiles.tile_set.tile_size.x, tiles.tile_set.tile_size.y)
	
	for x in range(map_size.x):
		map_info.append([])
		for y in range(map_size.y):
			map_info[x].append(0)
	# generate randomly seeded simplex noise map`
	noise = FastNoiseLite.new()
	noise.seed = randi_range(0, 10000)
	
	GenMap()
	draw_map()
	if (player != null):
		player.global_position=Vector2(entrance.x+(tile_size.x/2),entrance.y)
	exit.global_position=Vector2(entrance.x-(tile_size.x/2),entrance.y)
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func GenMap ():
	
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = alt_freq
	noise.fractal_octaves = oct
	noise.fractal_lacunarity = lac
	noise.fractal_gain = gain
	var noise_image = noise.get_image(map_size.x, map_size.y)
	
	for x in map_size.x:
		for y in map_size.y:
			if x >= border && x + border < map_size.x && y >= border && y + border < map_size.y:
				if (abs(noise.get_noise_2d(x,y) * 2 - 1 ) > cut_off):
					tiles.set_cell(0,Vector2i(x,y),0, Vector2i(2,0), 0)
					map_info[x][y] = 0
				else:
					tiles.set_cell(0,Vector2i(x,y),0, Vector2i(0,0), 0)
					map_info[x][y] = 1
			else:
				tiles.set_cell(0,Vector2i(x,y),0, Vector2i(0,0), 0)
				map_info[x][y] = 1
	
	connect_rooms()
	place_items()
	
	
	

func draw_map():
	
	for x in map_size.x:
		for y in map_size.y:
			#Border
			if x < border || x >= map_size.x-border || y < border || y >= map_size.y-border:
				if (x >= border-1 && x <= map_size.x-border) && (y >= border-1 && y <= map_size.y-border):
					tiles.set_cell(0,Vector2i(x,y),0, Vector2i(7+(x%2), y%2), 0)
				else:
					tiles.set_cell(0,Vector2i(x,y),0, Vector2i(0, 5), 0)
			else:
				if (map_info[x][y] == 0):
					if (map_info[x+1][y] == 0):
						if (map_info[x-1][y] == 0):
							if (map_info[x][y-1] == 0):
								tiles.set_cell(0,Vector2i(x,y),0, Vector2i(4+(x%2), 2+y%2), 0)
							elif (map_info[x][y-1] == 1):
								tiles.set_cell(0,Vector2i(x,y),0, Vector2i(4+(x%2), 1), 0)
						elif (map_info[x-1][y] == 1):
							if (map_info[x][y-1] == 0):
								tiles.set_cell(0,Vector2i(x,y),0, Vector2i(4+(x%2), 2+y%2), 0)
							elif (map_info[x][y-1] == 1):
								tiles.set_cell(0,Vector2i(x,y),0, Vector2i(3, 1), 0)
					elif (map_info[x+1][y] == 1):
						if (map_info[x-1][y] == 0):
							if (map_info[x][y-1] == 0):
								tiles.set_cell(0,Vector2i(x,y),0, Vector2i(4+(x%2), 2+y%2), 0)
							elif (map_info[x][y-1] == 1):
								tiles.set_cell(0,Vector2i(x,y),0, Vector2i(6, 1), 0)
						elif (map_info[x-1][y] == 1):
							if (map_info[x][y-1] == 0):
								tiles.set_cell(0,Vector2i(x,y),0, Vector2i(4+(x%2), 2+y%2), 0)
							elif (map_info[x][y-1] == 1):
								#Can't exist
								tiles.set_cell(0,Vector2i(x,y),0, Vector2i(7+(x%2), y%2), 0)
				elif (map_info[x][y] == 1):
					if (map_info[x+1][y] == 0):
						if (map_info[x-1][y] == 0):
							if (map_info[x][y+1] == 0):
								if (map_info[x][y-1] == 0):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(5, 0), 0)
								elif (map_info[x][y-1] == 1):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(5, 0), 0)
							elif (map_info[x][y+1] == 1):
								if (map_info[x][y-1] == 0):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(5, 0), 0)
								elif (map_info[x][y-1] == 1):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(5, 0), 0)
						elif (map_info[x-1][y] == 1):
							if (map_info[x][y+1] == 0):
								if (map_info[x][y-1] == 0):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(1, 3), 0)
								elif (map_info[x][y-1] == 1):								
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(2, 1), 0)
							elif (map_info[x][y+1] == 1):
								if (map_info[x][y-1] == 0):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(7, 0), 0)
								elif (map_info[x][y-1] == 1):
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(1, 3), 0)
					elif (map_info[x+1][y] == 1):
						if (map_info[x-1][y] == 0):
							if (map_info[x][y+1] == 0):
								if (map_info[x][y-1] == 0):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(10, 3), 0)
								elif (map_info[x][y-1] == 1):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(5, 0), 0)
							elif (map_info[x][y+1] == 1):
								if (map_info[x][y-1] == 0):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(2, 0), 0)
								elif (map_info[x][y-1] == 1):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(10, 3), 0)
						elif (map_info[x-1][y] == 1):
							if (map_info[x][y+1] == 0):
								if (map_info[x][y-1] == 0):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(4+x%2, 0), 0)
								elif (map_info[x][y-1] == 1):								
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(4+x%2, 0), 0)
							elif (map_info[x][y+1] == 1):
								if (map_info[x][y-1] == 0):
									#Can't exist
									tiles.set_cell(0,Vector2i(x,y),0, Vector2i(2+x%2, 4), 0)
								elif (map_info[x][y-1] == 1):
									if (map_info[x+1][y+1] == 0):
										tiles.set_cell(0,Vector2i(x,y),0, Vector2i(8, 4), 0)
									elif (map_info[x+1][y-1] == 0):
										tiles.set_cell(0,Vector2i(x,y),0, Vector2i(1, 4), 0)
									elif (map_info[x-1][y+1] == 0):
										tiles.set_cell(0,Vector2i(x,y),0, Vector2i(7, 4), 0)
									elif (map_info[x-1][y-1] == 0):
										tiles.set_cell(0,Vector2i(x,y),0, Vector2i(4, 4), 0)
									else:
										tiles.set_cell(0,Vector2i(x,y),0, Vector2i(0, 5), 0)
							
					
			


func connect_rooms():
	for x in map_size.x:
		for y in map_size.y:
			if !(x == 0 || x == map_size.x-1 || y == 0 || y == map_size.y-1):
				if (map_info[x+1][y] == 0 && map_info[x-1][y] == 0):
					map_info[x][y] = 0
				if (map_info[x][y+1] == 0 && map_info[x][y-1] == 0):
					map_info[x][y] = 0
	room_index_map = find_all_rooms()
	

func find_all_rooms():
	var rooms = 0;
	var room_id_map = []
	for x in range(map_size.x):
		room_id_map.append([])
		for y in range(map_size.y):
			room_id_map[x].append(-1)
	for x in map_size.x:
		for y in map_size.y:
			if map_info[x][y] == 0 && room_id_map[x][y] == -1:
				expand_room(room_id_map, x, y, rooms)
				rooms = rooms + 1
	return room_id_map
	
func expand_room(room_id_map, x, y, id):
	var room_size = 0;
	var cur_pos = Vector2i(x,y)
	var queue = []
	var tiles_in_room = []
	queue.append(cur_pos)
	
	while queue.is_empty() == false:
		cur_pos = queue.pop_back()
		room_id_map[cur_pos.x][cur_pos.y] = id
		tiles_in_room.append(cur_pos)
		room_size += 1
		var next_pos = Vector2i(min(cur_pos.x + 1, map_size.x-1),cur_pos.y)
		if (map_info[next_pos.x][next_pos.y] == 0 && room_id_map[next_pos.x][next_pos.y] != id):
			queue.append(next_pos)
		next_pos = Vector2i(cur_pos.x,min(cur_pos.y + 1, map_size.y-1))
		if (map_info[next_pos.x][next_pos.y] == 0 && room_id_map[next_pos.x][next_pos.y] != id):
			queue.append(next_pos)
		next_pos = Vector2i(max(cur_pos.x - 1, 0),cur_pos.y)
		if (map_info[next_pos.x][next_pos.y] == 0 && room_id_map[next_pos.x][next_pos.y] != id):
			queue.append(next_pos)
		next_pos = Vector2i(cur_pos.x,max(cur_pos.y - 1, 0))
		if (map_info[next_pos.x][next_pos.y] == 0 && room_id_map[next_pos.x][next_pos.y] != id):
			queue.append(next_pos)
	tiles_in_rooms.append(room_size)
	if (tiles_in_rooms.max() == room_size):
		largest_room = id
		tiles_in_largest_room = tiles_in_room
		entrance = Vector2i(x * tile_size.x + tile_size.x/2,y*tile_size.y + tile_size.y/2)
		for xi in map_size.x:
			for yi in map_size.y:
				if (room_id_map[xi][yi] == id && map_info[xi+1][yi] == 0 && map_info[xi-1][yi] == 0 && map_info[xi][yi+1] == 0 && map_info[xi][yi-1] == 0):
					entrance = Vector2i(xi * tile_size.x + tile_size.x/2,yi*tile_size.y + tile_size.y/2)
					return
	



func place_items():
	#Gold
	for i in number_gold:
		var loc = tiles_in_largest_room.pick_random()
		var gold_instance = gold.instantiate()
		gold_instance.global_position = Vector2(loc.x * tile_size.x + tile_size.x/2,loc.y*tile_size.y + tile_size.y/2)
		gold_instance.z_index = 90
		%Gold_holder.add_child(gold_instance)
		
	#Whiskey
	for i in number_whiskey:
		var loc = tiles_in_largest_room.pick_random()
		var whiskey_instance = whiskey.instantiate()
		whiskey_instance.global_position = Vector2(loc.x * tile_size.x + tile_size.x/2,loc.y*tile_size.y + tile_size.y/2)
		whiskey_instance.z_index = 90
		%Gold_holder.add_child(whiskey_instance)
	
				
	# Enemies
	for i in number_bats:
		var loc = tiles_in_largest_room.pick_random()
		var bat_instance = bat.instantiate()
		bat_instance.player = player
		bat_instance.global_position = Vector2(loc.x * tile_size.x + tile_size.x/2,loc.y*tile_size.y + tile_size.y/2)
		add_child(bat_instance)
	
	# Enemies
	for i in number_dogs:
		var loc = tiles_in_largest_room.pick_random()
		var dog_instance = dog.instantiate()
		dog_instance.player = player
		dog_instance.global_position = Vector2(loc.x * tile_size.x + tile_size.x/2,loc.y*tile_size.y + tile_size.y/2)
		add_child(dog_instance)
	# Enemies
	for i in number_grips:
		var loc = tiles_in_largest_room.pick_random()
		var grip_instance = grip.instantiate()
		grip_instance.player = player
		grip_instance.global_position = Vector2(loc.x * tile_size.x + tile_size.x/2,loc.y*tile_size.y + tile_size.y/2)
		add_child(grip_instance)

