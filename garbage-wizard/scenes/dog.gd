extends CharacterBody2D

signal player_bitten

@export var detection_radius = 200.0
@export var charge_duration = 1.2
@export var dash_speed = 1200
@export var normal_speed = 80.0

@onready var mouth_area = $Bite
@onready var detection_area = $Radius
@onready var line = $DashLine

enum State { IDLE, TRACKING, CHARGING, DASHING, COOLDOWN }

var state = State.TRACKING
var target: Node2D = null
var dash_direction = Vector2.ZERO
var charge_timer = 0.0
var cooldown_timer = 0.0

func _ready() -> void:
	detection_area.body_entered.connect(_on_body_entered)
	detection_area.body_exited.connect(_on_body_exited)
	mouth_area.body_entered.connect(_on_mouth_hit)

	# Pre-initialize exactly 2 points so set_point_position never fails
	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2.ZERO)

	line.visible = false
	line.width = 12
	line.default_color = Color(0.0, 0.4, 1.0, 0.55)  # thick blue, semi-transparent

func _physics_process(delta: float) -> void:
	match state:
		State.TRACKING:
			_track(delta)
		State.CHARGING:
			_charge(delta)
		State.DASHING:
			_dash(delta)
		State.COOLDOWN:
			cooldown_timer -= delta
			if cooldown_timer <= 0:
				state = State.TRACKING if target else State.IDLE

func _track(delta: float) -> void:
	if not target:
		state = State.IDLE
		return
	var dir = (target.global_position - global_position).normalized()
	rotation = dir.angle()
	_start_charge()

func _start_charge() -> void:
	state = State.CHARGING
	charge_timer = charge_duration
	dash_direction = Vector2.ZERO
	line.visible = true

func _charge(delta: float) -> void:
	if not target:
		state = State.IDLE
		line.visible = false
		return

	charge_timer -= delta

	# Keep rotating toward player during windup
	var dir = (target.global_position - global_position).normalized()
	rotation = dir.angle()

	# Line always points from enemy origin toward player in LOCAL space
	line.set_point_position(0, Vector2.ZERO)
	line.set_point_position(1, to_local(global_position + dir * 400))

	# Flash to warn player
	line.modulate.a = 0.5 + 0.5 * sin(charge_timer * 20)

	if charge_timer <= 0:
		dash_direction = dir       # lock direction at the moment of dash
		line.modulate.a = 1.0
		state = State.DASHING

func _dash(delta: float) -> void:
	velocity = dash_direction * dash_speed
	move_and_slide()

	line.visible = false

	if get_slide_collision_count() > 0 or velocity.length() < 10:
		_end_dash()

func _end_dash() -> void:
	state = State.COOLDOWN
	cooldown_timer = 1.0
	velocity = Vector2.ZERO

func _on_body_entered(body: Node2D) -> void:
	if body == Wizard and state == State.IDLE:
		target = body
		state = State.TRACKING

func _on_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
		state = State.IDLE
		line.visible = false

func _on_mouth_hit(body: Node2D) -> void:
	if body == Wizard and state == State.DASHING:
		Wizard.take_hit()
