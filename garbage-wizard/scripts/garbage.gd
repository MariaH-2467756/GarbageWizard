extends StaticBody2D

@onready var prompt = $EButton  # your E button image
var player_nearby = false
@export var garbage_id: String = ""## doesnt work get_path() ## path is unique so unique id.

func _ready():
	prompt.visible = false
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("ui_accept"):  # or make a custom "interact" action
		cleanUp()

func _on_body_entered(body):
	if body == Wizard:
		player_nearby = true
		prompt.visible = true

func _on_body_exited(body):
	if body == Wizard:
		player_nearby = false
		prompt.visible = false

func cleanUp():
	
	get_parent().on_garbage_cleaned(garbage_id)
	queue_free()
