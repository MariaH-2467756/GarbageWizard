extends StaticBody2D

func _ready() -> void:
	$GarbageLabel.text = str(GameState.garbage_collected) + "/" + str(GameState.garbage_max)
	

## this is enoug cause no garbage in prtal room this only needs update on ready when go into portal room.
