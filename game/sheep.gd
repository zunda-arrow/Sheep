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
	rotation = rotate_sheep(angle)

func preview(to: Vector2, angle: float):
	$"SheepGoTo".global_position = $"../TileMap".map_to_local(to)
	$SheepGoTo.global_rotation = rotate_sheep(angle)

func rotate_sheep(facing: float):
	return facing - (PI / 6)

func move(tilemap: TileMapLayer, to: Vector2):
	pos = to
	return to
