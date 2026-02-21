extends CharacterBody2D

signal hit

var speed = 400
var health = 3
var controls_active = true

func _ready() -> void:
	# hide()
	pass

func _physics_process(delta: float) -> void:
	if controls_active:
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

func check_player_collision() -> void: # not finished
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.get_collider().name)

func start(pos : Vector2, given_health : int) -> void:
	position = pos
	health = given_health
	
	controls_active = true
	$CollisionShape2D.disabled = false
	
	show()

func got_hit() -> void:
	health -= 1
	hit.emit()
	$CollisionShape2D.disabled = true

func die() -> void:
	health = 1
	got_hit()

func delete() -> void:
	queue_free()

func disable_controls() -> void:
	controls_active = false

func enable_controls() -> void:
	controls_active = true

# to show animation when garbage collected.
func clean_garbage():
	pass
