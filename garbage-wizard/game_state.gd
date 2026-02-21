extends Node
var garbage_max = 20
var garbage_collected = 0
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
