extends Node

signal set_level(level: Level)

var levels: Array[Level] = []


func _ready():
	load_levels()
	
	set_level.emit(levels[0])

func load_levels() -> void:
	levels = []
	for file_name in DirAccess.get_files_at("res://assets/resources/levels"):
		file_name = file_name.trim_suffix(".remap").trim_suffix(".import")
		var resource = null
		if file_name.ends_with(".tres"):
			resource = ResourceLoader.load("res://assets/resources/levels/" + file_name)
		if resource is Level:
			levels.append(resource) 
	levels.sort_custom(func(lvl1: Level, lvl2: Level): return lvl1.level < lvl2.level)
