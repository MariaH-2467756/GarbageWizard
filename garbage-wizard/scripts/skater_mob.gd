extends RigidBody2D

@export var speed : int
@export var direction : float
@export var bound : int

var start_position : Vector2
var angular_speed = PI
var wrap_around = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position += Vector2(100, 100)
	start_position = position

func set_values(given_speed : int, given_direction : float, given_bound : int) -> void:
	speed = given_speed
	direction = given_direction
	bound = given_bound

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mob_movement(delta)


func mob_movement(delta: float) -> void:
	var input_vector = Vector2.UP
	
	var delta_position
	
	if position > start_position:
		delta_position = position.x - start_position.x
	else:
		delta_position = start_position.x - position.x
	
	$AnimatedSprite2D.play()
	if direction >= 0:
		if speed > 0:
			$AnimatedSprite2D.animation = "skate_right"
		else:
			$AnimatedSprite2D.animation = "skate_left"
	else:
		if speed > 0:
			$AnimatedSprite2D.animation = "skate_left"
		else:
			$AnimatedSprite2D.animation = "skate_right"
	
	if delta_position > bound:
		if wrap_around:
			wrap_around = false
			change_direction()
		else:
			wrap_around = true
			change_direction()
	
	rotation = angular_speed * direction
	position += input_vector.rotated(rotation) * speed * delta

func change_direction() -> void:
	speed = speed * -1
