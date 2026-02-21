extends CharacterBody2D

signal hit

var speed = 400
var angular_speed = PI
var health = 3

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	wizard_movement(delta)
	
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
	
func die() -> void: # function to help debug
	health = 0
	$CollisionShape2D.set_deferred("disabled", true)
	hit.emit()

"""func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	health -= 1
	$CollisionShape2D.set_deferred("disabled", true)"""

#a function to call wel telporting with player animation.
func teleport():
	pass
func delete() -> void:
	queue_free()
