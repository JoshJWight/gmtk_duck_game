extends CharacterBody2D

@export var standing: Texture2D
@export var walk1: Texture2D
@export var walk2: Texture2D
@export var jumping: Texture2D
@export var falling: Texture2D
@export var gliding: Texture2D

const SPRITE_STANDING = 0;
const SPRITE_WALK1 = 1;
const SPRITE_WALK2 = 2;
const SPRITE_JUMPING = 3;
const SPRITE_FALLING = 4;
const SPRITE_GLIDING = 5;

const SPEED := 250.0
const JUMP_VELOCITY := -300.0
const GRAVITY := 1200.0

const GLIDING_TERMINAL_VELOCITY = 50

const WALK_CYCLE_LENGTH = 0.2
const FLAP_LENGTH = 0.2

var max_down = 5
var current_down = 0

var jumpCooldown = 0

var walkCycleTimer = 0

var currentSprite = SPRITE_STANDING

var facingDirection = 1.0

func setCurrentDown(val: int) -> void:
	current_down = val
	get_tree().call_group(
		"hud",
		"setCurrentDown",
		current_down)
		
func setMaxDown(val: int) -> void:
	max_down = val
	get_tree().call_group(
		"hud",
		"setMaxDown",
		max_down)
	if(current_down > max_down):
		setCurrentDown(max_down)
		
func collectDuckling() -> void:
	setMaxDown(max_down - 1)
	
func updateSprite() -> void:
	match currentSprite:
		SPRITE_STANDING:
			$DuckSprite.texture = standing
		SPRITE_WALK1:
			$DuckSprite.texture = walk1
		SPRITE_WALK2:
			$DuckSprite.texture = walk2
		SPRITE_JUMPING:
			$DuckSprite.texture = jumping
		SPRITE_FALLING:
			$DuckSprite.texture = falling
		SPRITE_GLIDING:
			$DuckSprite.texture = gliding
		_:
			print("ERROR: Invalid sprite enum")
	$DuckSprite.flip_h = facingDirection < 0

func _physics_process(delta: float) -> void:
	#Fall through one-ways if holding down
	set_collision_mask_value(2, !Input.is_action_pressed("ui_down"))
	
	var direction := Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	if direction != 0:
		facingDirection = direction
	
	if not is_on_floor():
		if Input.is_action_pressed("ui_accept") and velocity.y > 0:
			currentSprite = SPRITE_GLIDING
			#Gliding
			if velocity.y > GLIDING_TERMINAL_VELOCITY:
				velocity.y -= GRAVITY * delta
			else:
				velocity.y += GRAVITY/2.0 * delta
		else:
			if jumpCooldown > 0:
				jumpCooldown -= delta
				currentSprite = SPRITE_JUMPING
			else:
				currentSprite = SPRITE_FALLING
			velocity.y += GRAVITY * delta
	else:
		if velocity.x == 0:
			currentSprite = SPRITE_STANDING
		else:
			if walkCycleTimer > 0:
				walkCycleTimer -= delta
			else:
				if currentSprite == SPRITE_WALK1:
					walkCycleTimer = WALK_CYCLE_LENGTH
					currentSprite = SPRITE_WALK2
				else:
					walkCycleTimer = WALK_CYCLE_LENGTH
					currentSprite = SPRITE_WALK1
			
	
	if is_on_floor() and current_down != max_down:
		setCurrentDown(max_down)

	if Input.is_action_just_pressed("ui_accept") and current_down > 0 and jumpCooldown <= 0:
		velocity.y = JUMP_VELOCITY
		setCurrentDown(current_down - 1)
		jumpCooldown = FLAP_LENGTH

	updateSprite()
	move_and_slide()
