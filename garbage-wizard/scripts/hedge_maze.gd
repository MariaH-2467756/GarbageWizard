extends Node2D
var portal_room = "res://scenes/portal_room.tscn"

@onready var timer_label = $TimerLayer/Time
var max_time = 300.0
var time_elapsed = 0.0
var time_left = 0.0

#Garbage collection
#######
func on_garbage_cleaned(garbage_id: String):
	if (GameState.on_garbage_cleaned(garbage_id)):
		GameState.garbage_maze += 1
		
		if GameState.garbage_maze >= GameState.garbage_maze_max:
			get_tree().change_scene_to_file(portal_room)
#######

func _ready():
	Wizard.start(Vector2(0, 0), 3)
	time_elapsed = 0.0
	

func _process(delta):
	time_elapsed += delta
	time_left = max_time - time_elapsed
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	timer_label.text = "Time Left:\n%02d:%02d" % [minutes, seconds]
	
	if time_left <= 60.0:
		timer_label.add_theme_color_override("font_color", Color.RED)
	
	if time_left <= 0.0:
		get_tree().change_scene_to_file(portal_room)
