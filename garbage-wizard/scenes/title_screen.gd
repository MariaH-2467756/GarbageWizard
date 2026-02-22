extends CanvasLayer

signal start_game


func _on_start_pressed() -> void:
	start_game.emit()
