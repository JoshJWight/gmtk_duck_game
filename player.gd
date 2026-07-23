extends CharacterBody2D

const SPEED := 250.0
const JUMP_VELOCITY := -300.0
const GRAVITY := 1200.0

const GLIDING_TERMINAL_VELOCITY = 50

var max_down = 5
var current_down = max_down


func setCurrentDown(val: float) -> void:
	current_down = val
	get_tree().call_group(
		"hud",
		"setCurrentDown",
		current_down)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if Input.is_action_pressed("ui_accept") and velocity.y > 0:
			#Gliding
			if velocity.y > GLIDING_TERMINAL_VELOCITY:
				velocity.y -= GRAVITY * delta
			else:
				velocity.y += GRAVITY/2.0 * delta
		else:
			velocity.y += GRAVITY * delta
	
	if is_on_floor() and current_down != max_down:
		setCurrentDown(max_down)

	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED

	if Input.is_action_just_pressed("ui_accept") and current_down > 0:
		velocity.y = JUMP_VELOCITY
		setCurrentDown(current_down - 1)

	move_and_slide()
