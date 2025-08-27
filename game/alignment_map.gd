extends TileMapLayer

signal set_alignment(map: TileMapLayer)

func _ready():
    set_alignment.emit(self)

func set_level(level: Level) -> void:
    clear()
    var tilemap: TileMapLayer = level.grass.instantiate()
    for cell in tilemap.get_used_cells():
        set_cell(cell, 1, Vector2i.ZERO)
