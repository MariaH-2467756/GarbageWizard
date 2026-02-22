extends Node2D
var portal_room = "res://scenes/portal_room.tscn"

#######
func on_garbage_cleaned(garbage_id: String):
	if (GameState.on_garbage_cleaned(garbage_id)):
		GameState.garbage_forest_max += 1
		
		if GameState.garbage_forest >= GameState.garbage_forest_max:
			get_tree().change_scene_to_file(portal_room)
#######

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
