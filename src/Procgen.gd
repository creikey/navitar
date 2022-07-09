extends Node2D

export (NodePath) var player_path
var active_tiles = {}

onready var player: Node2D = get_node(player_path)

func _ready():
	gen(to_tile_coords(Vector2()))

func _process(delta):
#	if get_center(to_tile_coords(player.global_position)).distance_to(player.global_position) > Game.tile/4.0:
	for x in range(-1, 2):
		for y in range(-1, 2):
			gen(to_tile_coords(player.global_position) + Vector2(x, y))

func to_tile_coords(global_pos: Vector2):
	var floating = global_pos/Game.tile
	return Vector2(floor(floating.x), floor(floating.y))

func get_center(pos_tile: Vector2) -> Vector2:
	return (pos_tile*Game.tile)+Vector2(Game.tile, Game.tile)/2.0

func gen(pos_tile: Vector2): # pos is in tile coorinates
	if active_tiles.has(pos_tile*Game.tile):
		return
	print("Generating ", pos_tile)
	var new_tile = preload("res://GameTile.tscn").instance()
	add_child(new_tile)
	new_tile.global_position = pos_tile*Game.tile
	new_tile.player = player
	new_tile.generate()
	new_tile.connect("deleting", self, "_on_deleting")
	active_tiles[pos_tile*Game.tile] = new_tile

func _on_deleting(pos):
	print("Deleting ", to_tile_coords(pos))
	if not active_tiles.erase(pos):
		printerr("Error tile not found: ", pos)
