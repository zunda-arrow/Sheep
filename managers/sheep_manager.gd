extends "res://managers/object_manager.gd"

func _input(event):
	if event is InputEventMouseMotion:
		look_away(alignment_map.local_to_map(alignment_map.to_local(event.position)))

## Points all objects away from 
func look_away(from: Vector2i) -> void:
	for pos in objects:
		var angle = Vector2(from - pos).angle()
		print(rad_to_deg(angle))
		objects[pos].rotation = rad_to_rot(angle)
