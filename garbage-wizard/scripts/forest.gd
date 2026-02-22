extends Node2D
var portal_room = "res://scenes/portal_room.tscn"

#######
@export var garbage_max = 5 
var garbage_collected = 0
func on_garbage_cleaned(garbage_id: String):
	if (GameState.on_garbage_cleaned(garbage_id)):
		garbage_collected += 1
		
		if garbage_collected >= garbage_max:
			get_tree().change_scene_to_file(portal_room)
#######

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
