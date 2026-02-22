extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open_titlescreen()
	Wizard.hit.connect(wizard_health_check)
	
	# debug tool
	# await get_tree().create_timer(10).timeout
	# $Wizard.die()

func wizard_health_check() -> void:
	print(Wizard.health)
	if (Wizard.health) <= 0:
		game_over()
	else: # return to start position (health gets decreased in $Wizard)
		pass
		#Wizard.position = $StartPosition.position

func game_over() -> void:
	Wizard.hide()
	$GameOverScreen.show()
	Wizard.position = $StartPosition.position
	Wizard.disable_controls()

func new_game() -> void:
	var health = 3
	$TitleScreen.hide()
	get_tree().change_scene_to_file("res://scenes/portal_room.tscn")
	MainTimer.reset()
	#Wizard.start($StartPosition.position, health)

func open_titlescreen() -> void:
	$GameOverScreen.hide()
	$TitleScreen.show()
	
	#a function to call wel telporting with player animation.
func teleport():
	await (get_tree().create_timer(1).timeout)
	Wizard.position = $StartPosition.position
