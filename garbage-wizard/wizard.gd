extends CharacterBody2D

var speed = 400
var angular_speed = PI

func _physics_process(delta: float) -> void:
	var direction = 0
	
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	
	rotation += angular_speed * delta * direction
	
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		input_vector = Vector2.UP
	if Input.is_action_pressed("ui_down"):
		input_vector = Vector2.DOWN
	
	velocity = input_vector.rotated(rotation) * speed
	
	move_and_slide()
