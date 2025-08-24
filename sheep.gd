extends Node2D
class_name Sheep

@export var pos: Vector2i

func _ready() -> void:
	pos = $"../TileMap".local_to_map(position)
	position = $"../TileMap".map_to_local(pos)
	$SheepGoTo.visible = true

func go(to: Vector2i, angle: float):
	pos = to
	position = $"../TileMap".map_to_local(to)

func preview(to: Vector2, angle: float):
	$"SheepGoTo".global_position = $"../TileMap".map_to_local(to)
	$SheepGoTo.rotation = rotate_sheep(angle)

func rotate_sheep(facing: float):
	return facing - (PI / 6)

func move(tilemap: TileMap, to: Vector2):
	pos = to
	return to
