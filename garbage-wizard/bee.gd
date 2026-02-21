extends CharacterBody2D

@export var speed = 80.0 # seconds to retreat after hitting player

var target_position: Vector2
var chasing = false


@onready var hive_position = $"..".global_position

func _ready():
	$"../Area2D".body_entered.connect(_on_body_entered)
	$"../Area2D".body_exited.connect(_on_body_exited)
	$HitArea.body_entered.connect(_on_hit_player)
	target_position = hive_position

func _physics_process(delta):
	if chasing:
		target_position = Wizard.global_position
	else:
		target_position = hive_position
	
	var direction = (target_position - global_position).normalized()
	var distance = global_position.distance_to(target_position)
	
	if distance > 5.0:
		velocity = direction * speed
		rotation = atan2(direction.y, direction.x) + PI/2
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func _on_body_entered(body):
	if body == Wizard:
		chasing = true

func _on_body_exited(body):
	if body == Wizard:
		chasing = false

func _on_hit_player(body):
	if body == Wizard:
		$Sprite2D.modulate = Color(1, 0, 0, 0.5)  # red and transparent
		await get_tree().create_timer(0.1).timeout
		queue_free()
