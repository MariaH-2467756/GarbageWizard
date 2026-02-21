extends CanvasLayer

signal homepage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Title.hide()
	$ReturnToHome.hide()

func _on_visibility_changed() -> void:
	if visible:
		await get_tree().create_timer(1.0).timeout
		$Title.show()
		await get_tree().create_timer(1.0).timeout
		$ReturnToHome.show()


func _on_return_to_home_pressed() -> void:
	homepage.emit()
