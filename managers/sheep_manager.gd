extends "res://managers/object_manager.gd"

func _input(event):
	if event is InputEventMouseMotion:
		look_away(event.position)

## Points all objects away from 
func look_away(from: Vector2) -> void:
	for pos in objects:
		var to = objects[pos].aligned_to.to_global(objects[pos].aligned_to.map_to_local(pos))
		var angle = (to - from).angle()
		objects[pos].rotation = rad_to_rot(angle)
