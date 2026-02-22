extends StaticBody2D

@export var next_scene: String = "res://scenes/hedge_maze.tscn"

@onready var prompt = $EButton  # your E button image
@onready var label = $GarbageLeft
var player_nearby = false

func _ready():
	prompt.visible = false
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)
	var scene = load(next_scene).instantiate()
	label.text = str(GameState.garbage_maze) + " / " + str(GameState.garbage_maze_max) 
	scene.free()

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("ui_accept"):  # or make a custom "interact" action
		teleport()

func _on_body_entered(body):
	if body == Wizard:
		player_nearby = true
		prompt.visible = true

func _on_body_exited(body):
	if body == Wizard:
		player_nearby = false
		prompt.visible = false

func teleport():
	get_tree().change_scene_to_file(next_scene)
