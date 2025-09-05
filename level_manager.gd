extends Node

var levels: Dictionary = {
	"menu": "",
	"level1":"res://level.tscn",
	"level2":"res://level_2.tscn"
}

var current_level_index = 1

func load_level(identifier) -> void:
	var type = typeof(identifier)
	if type == TYPE_INT:
		if identifier >= 0 and identifier < levels.size():
			current_level_index = identifier
			var key = levels.keys()[identifier]
			_load_scene(levels[key])
		else:
			push_error("Index out of range")
	elif type == TYPE_STRING:
		if levels.has(identifier):
			current_level_index = levels.keys().find(identifier)
			_load_scene(levels[identifier])
		else:
			push_error("Level not found")
			
func load_next_level():
	load_level(current_level_index + 1)
	
func _load_scene(path):
	get_tree().change_scene_to_file(path)
	
