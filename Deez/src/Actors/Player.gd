extends Actor

var direction: = Vector2.ZERO
onready var weapon = $Attacks

func _unhandled_input(event):
	if event.is_action_pressed("mid_attack"):
		weapon.midattack()
	if event.is_action_pressed("low_attack"):
		weapon.lowattack()
	if event.is_action_pressed("high_attack"):
		weapon.highattack()
	if event.is_action_pressed("back_attack"):
		weapon.backattack()

func _physics_process(delta):
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	direction = get_direction()
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool
	) -> Vector2:
	var new_velocity: = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity
