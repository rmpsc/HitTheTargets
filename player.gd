extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -600.0
@onready var player_animation = $PlayerAnimation

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * 2
		var isFalling = velocity.y > 0
		if isFalling:
			player_animation.animation = "fall"
		else:
			player_animation.animation = "jump"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED

		var isRight = velocity.x > 0
		if isRight:
			player_animation.flip_h = true
		else:
			player_animation.flip_h = false
		player_animation.animation = "run"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		player_animation.animation = "idle"

	move_and_slide()
