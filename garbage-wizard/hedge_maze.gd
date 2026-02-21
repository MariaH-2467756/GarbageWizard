extends Node2D
@export var garbage_collected = 0
@export var garbage_max = 5
@onready var timer_label = $TimerLayer/Time
var portal_room = "res://scenes/portal_room.tscn"
var max_time = 300.0
var time_elapsed = 0.0
var time_left = 0.0

func _ready():
	Wizard.position = Vector2(0, 0)
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
