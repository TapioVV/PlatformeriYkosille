extends PlayerState

class_name FallState

func _physics_process(delta):
	player.inputVector = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	player.velocity.x = move_toward(player.velocity.x, player.inputVector*player.maxHorizontalSpeed, player.ACCELERATION*delta)
	if player.is_on_floor():
		if player.velocity.x != 0:
			change_state.call_func("run")
		else:
			change_state.call_func("idle")
	player.velocity.y += player.gravity * delta


