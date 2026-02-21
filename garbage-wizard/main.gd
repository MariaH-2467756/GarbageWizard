extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Wizard.hide()
	open_titlescreen()
	
	#debug tool
	# await get_tree().create_timer(3).timeout
	# $Wizard.die()

func wizard_health_check() -> void:
	if $Wizard.health <= 0:
		game_over()
	else: # return to start position (health gets decreased in $Wizard)
		$Wizard.position = $StartPosition.position + Vector2(50, 50)

func game_over() -> void:
	# var position_wizard = $Wizard.position
	$Wizard.hide()
	# $GameOverScreen.offset = position_wizard
	$GameOverScreen.show()
	$Wizard.delete()

func new_game() -> void:
	$TitleScreen.hide()
	$Wizard.start($StartPosition.position)

func open_titlescreen() -> void:
	$GameOverScreen.hide()
	$TitleScreen.show()
