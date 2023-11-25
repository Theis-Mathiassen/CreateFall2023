extends Node2D
@onready
var tiles : TileMap = $Floor
@onready var player = $player

var border = 1
var map_size = Vector2i(64, 64)
var map_info = []
var tile_size

var number_rooms = 0
var tiles_in_rooms = []

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




# Called when the node enters the scene tree for the first time.
func _ready():
	tile_size = Vector2i(tiles.tile_set.tile_size.x, tiles.tile_set.tile_size.y)
	
	for x in range(map_size.x):
		map_info.append([])
		for y in range(map_size.y):
			map_info[x].append(0)
	# generate randomly seeded simplex noise map`
	noise = FastNoiseLite.new()
	noise.seed = noise_seed
	
	GenMap()
	draw_map()
	print(entrance)
	player.global_position=Vector2(entrance.x,entrance.y)
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	total_time += delta
	if (total_time > 1000):
		print(total_time)
		noise.seed = randi_range(0, 10000)
		GenMap()
		draw_map()
		total_time = 0
	pass


func GenMap ():
	
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = alt_freq
	noise.fractal_octaves = oct
	noise.fractal_lacunarity = lac
	noise.fractal_gain = gain
	var noise_image = noise.get_image(map_size.x, map_size.y)
	print(cut_off)
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
	
	
	

func draw_map():
	for x in map_size.x:
		for y in map_size.y:
			#Border
			if x == 0 || x == map_size.x-1 || y == 0 || y == map_size.y-1:
				tiles.set_cell(0,Vector2i(x,y),0, Vector2i(7+(x%2), y%2), 0)
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
	var room_index_map = find_all_rooms()
	

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
	queue.append(cur_pos)
	
	while queue.is_empty() == false:
		cur_pos = queue.pop_back()
		room_id_map[cur_pos.x][cur_pos.y] = id
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
		entrance = Vector2i(x * tile_size.x,y*tile_size.y)
	
