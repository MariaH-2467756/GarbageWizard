extends CharacterBody2D

signal hit

var speed = 400
@export var health = 3
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
	else:
		velocity = Vector2.ZERO

#func check_player_collision() -> void: # not finished
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#if (collision.get_collider().is_in_group("enemy")):
			#hit.emit()

func start(pos : Vector2, given_health : int) -> void:
	position = pos
	health = given_health
	
	controls_active = true
	$CollisionShape2D.disabled = false
	
	show()

func take_hit() -> void:
	health -= 1
	$Sprite2D.modulate = Color(1, 0, 0, 0.5)
	hit.emit()
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)

#func die() -> void:
	#health = 1
	#got_hit()

func delete() -> void:
	queue_free()

func disable_controls() -> void:
	controls_active = false

func enable_controls() -> void:
	controls_active = true

# to show animation when garbage collected.
func clean_garbage():
	pass
	
# function to telport back to portal room
var hold_timer = 0.0
var is_teleporting = false
var blink_timer = 0.0
var blink_interval = 0.15
var blink_state = false
var hold_time = 3.0

func _process(delta):
	if Input.is_action_pressed("ui_shift"):
		teleport(delta)
	else:
		# reset everything if shift released early
		if is_teleporting:
			hold_timer = 0.0
			is_teleporting = false
			blink_timer = 0.0
			blink_state = false
			modulate = Color(1.0, 1.0, 1.0, 1.0)

func teleport(delta):
	is_teleporting = true
	hold_timer += delta
	blink_timer += delta

	# blink blue see-through
	if blink_timer >= blink_interval:
		blink_timer = 0.0
		blink_state = !blink_state
		if blink_state:
			modulate = Color(0.3, 0.6, 1.0, 0.4)  # blue see-through
		else:
				modulate = Color(1.0, 1.0, 1.0, 1.0)  # normal

	# teleport once fully charged
	if hold_timer >= hold_time:
		hold_timer = 0.0
		is_teleporting = false
		modulate = Color(1.0, 1.0, 1.0, 1.0)
		get_tree().change_scene_to_file("res://scenes/portal_room.tscn")
	
