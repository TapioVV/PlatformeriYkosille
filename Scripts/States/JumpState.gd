extends PlayerState

class_name JumpState

func _ready():
	player.velocity.y = -player.jumpSpeed
	if player.smallJumpStart == true:
		player.velocity.y = player.velocity.y / player.smallJump
	else:
		null
	player.smallJumpStart == false

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
		if player.velocity.y < 0:
			player.velocity.y = player.velocity.y / player.smallJump

	if Input.is_action_just_pressed("Jump"):
		player.jumpPressed = true
		player.jumpTimer.start(player.jumpBufferTime)

	if player.is_on_floor():
		if player.velocity.x != 0:
			change_state.call_func("run")
		else:
			change_state.call_func("idle")
		if !player.jumpTimer.is_stopped():
			if player.jumpPressed == false:
				player.smallJumpStart = true
				change_state.call_func("jump")
			elif player.jumpPressed == true:
				player.smallJumpStart = false
			change_state.call_func("jump")

	if player.is_on_ceiling():
		player.velocity.y = 0


	player.velocity.y += player.gravity * delta
