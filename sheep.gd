extends Node2D
class_name Sheep

@onready var goto = $"../Sheep"

@export var pos: Vector2i

func _ready() -> void:
	position = $"../TileMap".map_to_local(pos)
	$Sheep.global_position = position

func preview(to: Vector2):
	$"SheepGoTo".global_position = $"../TileMap".map_to_local(to)

func move(tilemap: TileMap, to: Vector2):
	pos = to
	return to
