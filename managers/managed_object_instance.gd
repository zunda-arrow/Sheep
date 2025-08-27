## A managed object with extra, instance specific data.
class_name ManagedObjectInstance
extends Resource

## The tilemapLayer this object is aligned to
var aligned_to: TileMapLayer
@export var type: ManagedObject
@export var position: Vector2i : 
	set(value):
		position = value
		if sprite:
			sprite.position = aligned_to.to_global(
				aligned_to.map_to_local(value)
			)
@export_range(0, 6) var rotation: int :
	set(value):
		rotation = value
		if sprite:
			sprite.rotation_degrees = type.rotation_offset + value * 60
var sprite: Sprite2D = null

func set_properties(alignment: TileMapLayer, pos: Vector2i, rot: int, object: ManagedObject):
	aligned_to = alignment
	type = object
	generate_sprite()
	position = pos
	rotation = rot

## Generate a sprite and set it's rotation.
func generate_sprite() -> Sprite2D:
	if not sprite:
		sprite = Sprite2D.new()
		sprite.texture = type.texture
	sprite.position = aligned_to.to_global(aligned_to.map_to_local(position))
	sprite.rotation_degrees = type.rotation_offset + rotation * 60
	return sprite
