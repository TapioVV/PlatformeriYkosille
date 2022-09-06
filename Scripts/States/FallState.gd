extends PlayerState

class_name FallState

func _physics_process(delta):
	player.inputVector = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if player.inputVector == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, player.DEACCELERATION*delta/player.jumpControlDeacceleration)
	else:
		player.velocity.x = move_toward(player.velocity.x, player.inputVector*player.maxHorizontalSpeed, player.ACCELERATION*delta/player.jumpControlAcceleration)

	if Input.is_action_just_pressed("Jump"):
		player.timer.start(player.jumpBufferTime)
	if player.is_on_floor():
		if !player.timer.is_stopped():
			change_state.call_func("jump")
		if player.velocity.x != 0:
			change_state.call_func("run")
		else:
			change_state.call_func("idle")
	player.velocity.y += player.gravity * delta


