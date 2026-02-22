extends Node
@export var garbage_forest_max = 5
@export var garbage_forest = 0
@export var garbage_maze_max = 3
@export var garbage_maze = 0
@export var garbage_dogpark_max = 5
@export var garbage_skatepark_max = 5
@export var garbage_dogpark = 0
@export var garbage_skatepark = 0
var garbage_max = garbage_forest_max + garbage_maze_max + garbage_dogpark_max + garbage_skatepark_max
var garbage_collected = garbage_forest + garbage_maze + garbage_dogpark + garbage_skatepark
var cleaned: Array = []

func on_garbage_cleaned(node_id: String) -> bool:
	if (node_id not in cleaned):
		cleaned.append(node_id)
		Wizard.clean_garbage()
		garbage_collected += 1
		if (garbage_collected == garbage_max): ## ALL garb. Collected end game.
			end_game()
		return true
	else:
		return false

func end_game():
	pass
