extends Marker2D

@export var start_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_position = position
