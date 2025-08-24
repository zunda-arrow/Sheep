extends Node2D

var mouse_pos


var truck_pos = Vector2(2, 2)
@onready var sheepen: Array[Sheep] = [
	$Sheep1,
	$Sheep2,
]

func _ready() -> void:
	mouse_pos = $TileMap.get_local_mouse_position()

func _process(delta: float) -> void:
	for sheep in sheepen:
		mouse_pos = $TileMap.local_to_map($TileMap.get_local_mouse_position())

		var pos = $MouseClicked.move($TileMap, mouse_pos)
		$MouseClicked.position = $TileMap.map_to_local(pos)

		var goto = truck_go_to($TileMap.map_to_local(mouse_pos), $TileMap.map_to_local(sheep.pos))
		sheep.preview($TileMap.local_to_map(goto))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		for sheep in sheepen:
			sheep.go($TileMap.local_to_map(truck_go_to(get_local_mouse_position(), $TileMap.map_to_local(sheep.pos))))

func truck_go_to(mouse_pos: Vector2, truck_pos: Vector2) -> Vector2:
	var angle_to_truck = mouse_pos.angle_to(truck_pos)

	var new_vec = (truck_pos - mouse_pos).normalized()
	
	var d = sqrt(mouse_pos.distance_squared_to(truck_pos))
	var dist = d
	
	var x = new_vec.x * dist
	var y = new_vec.y * dist

	return Vector2(
		truck_pos.x + x,
		truck_pos.y + y,
	)
