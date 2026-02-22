extends CanvasLayer

@onready var timer_label =$Timer
var time_elapsed = 0.0

func _ready():
	time_elapsed = 0.0

func _process(delta):
	time_elapsed += delta
	var minutes = int(time_elapsed) / 60
	var seconds = int(time_elapsed) % 60
	timer_label.text = "Time Spent:\n%02d:%02d" % [minutes, seconds]


func reset():
	time_elapsed = 0.0
