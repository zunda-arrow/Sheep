extends Node

@export var level_property: StringName

## The tileMap sprite positions are aligned to.
var alignment_map: TileMapLayer
## Dictionary of object instances and their positions.
var objects: Dictionary[Vector2i, ManagedObjectInstance] = {}

func _ready():
	if not alignment_map:
		push_error("No assigned tilemap to align to, can't place objects!")

func load_level(level: Level) -> void:
	if not level_property:
		push_error("No property defined for manager %s" % name)
		return
	load_objects(level.get(level_property))

func load_objects(object_array: Array) -> void:
	for to_place in object_array:
		to_place.aligned_to = alignment_map
		to_place.generate_sprite()
		objects[to_place.position] = to_place
		add_child(objects[to_place.position].sprite)

## Set tilemap to reference for positioning functions.
func set_tilemap(map: TileMapLayer) -> void:
	alignment_map = map

## Add a tracked ManagedObject.
func place_object(pos: Vector2i, facing: int, object: ManagedObject) -> ManagedObjectInstance:
	objects[pos] = ManagedObjectInstance.new()
	objects[pos].set_properties(alignment_map, pos, facing, object)
	add_child(objects[pos].sprite)
	return objects[pos]

## Remove a given object.
func remove_object(object: ManagedObjectInstance) -> void:
	object.sprite.queue_free()
	objects.erase(object.position)

## Remove the object at a given position.
func remove_object_at(pos: Vector2i) -> void:
	remove_object(objects[pos])

## Remove all objects.
func clear_objects() -> void:
	for object in objects.values():
		object.sprite.queue_free()
	objects = {}

## Move and rotate an object.
func transform_object(object: ManagedObjectInstance, to: Vector2i, rotation: int) -> void:
	objects.erase(object.position)
	objects[object.position] = object
	objects[object.position].position = to
	objects[object.position].rotation = rotation

## Move and rotate an object that is currently at a given position.
func transform_object_at(from: Vector2i, to: Vector2i, rotation: int) -> void:
	transform_object(objects[from], to, rotation)

## Convert a value in radians to a managedObject's rotation value
func rad_to_rot(angle: float) -> int:
	return int(angle / (PI / 4)) + 1
