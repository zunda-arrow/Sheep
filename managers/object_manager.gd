extends Node

## The tileMap sprite positions are aligned to.
var alignment_map: TileMapLayer
## Dictionary of object instances and their positions.
var objects: Dictionary[Vector2i, ManagedObjectInstance] = {}

## A managed object with extra, instance specific data.
class ManagedObjectInstance:
    ## The tilemapLayer this object is aligned to
    var aligned_to: TileMapLayer

    var type: ManagedObject
    var position: Vector2i : 
        set(value):
            position = value
            if sprite:
                sprite.position = aligned_to.to_global(
                    aligned_to.map_to_local(value)
                )
    var rotation: int :
        set(value):
            rotation = value
            if sprite:
                sprite.rotation_degrees = type.rotation_offset + value * 60
    var sprite: Sprite2D = null

    func _init(alignment: TileMapLayer, pos: Vector2i, rot: int, object: ManagedObject):
        aligned_to = alignment
        type = object

        generate_sprite()

        position = pos
        rotation = rot
    
    ## Generate a sprite and set it's rotation.
    func generate_sprite() -> Sprite2D:
        if sprite:
            return sprite
        sprite = Sprite2D.new()
        sprite.texture = type.texture
        return sprite

## Set tilemap to reference for positioning functions.
func set_tilemap(map: TileMapLayer) -> void:
    alignment_map = map

## Add a tracked ManagedObject.
func place_object(pos: Vector2i, facing: int, object: ManagedObject) -> ManagedObjectInstance:
    objects[pos] = ManagedObjectInstance.new(alignment_map, pos, facing, object)
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

