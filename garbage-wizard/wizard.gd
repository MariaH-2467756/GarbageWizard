extends CharacterBody2D
var speed = 400

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("ui_left"):
		input_vector.x = -1
	if Input.is_action_pressed("ui_right"):
		input_vector.x = 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y = -1
	if Input.is_action_pressed("ui_down"):
		input_vector.y = 1
	
	velocity = input_vector.normalized() * speed
	move_and_slide()

# to show animation when garbage collected.
func clean_garbage():
	pass
	

#a function to call wel telporting with player animation.
func teleport():
	pass
