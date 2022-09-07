extends PlayerState

class_name FallState

func _ready():
	player.velocity.y = 0

func _physics_process(delta):
	player.inputVector = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if player.inputVector == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, player.DEACCELERATION*delta/player.jumpControlDeacceleration)
	else:
		player.velocity.x = move_toward(player.velocity.x, player.inputVector*player.maxHorizontalSpeed, player.ACCELERATION*delta/player.jumpControlAcceleration)

	if Input.is_action_just_pressed("Attack"):
		change_state.call_func("airattack")

	if Input.is_action_just_released("Jump"):
		player.jumpPressed = false

	if Input.is_action_just_pressed("Jump"):
		player.jumpTimer.start(player.jumpBufferTime)
		player.jumpPressed = true
	if player.is_on_floor():
		if player.velocity.x != 0:
			change_state.call_func("run")
		else:
			change_state.call_func("idle")
		if !player.jumpTimer.is_stopped():
			if player.jumpPressed == false:
				player.smallJumpStart = true
			elif player.jumpPressed == true:
				player.smallJumpStart = false
			change_state.call_func("jump")

	if player.is_on_ceiling():
		player.velocity.y = 0
	player.velocity.y += player.gravity * delta


