extends PlayerState

class_name AirAttackState

func _ready():
	animation_player.play("AardvarkAttackAnim")
	player.attack()


func _physics_process(delta):
	player.inputVector = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if player.inputVector == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, player.DEACCELERATION*delta/player.jumpControlDeacceleration)
	else:
		player.velocity.x = move_toward(player.velocity.x, player.inputVector*player.maxHorizontalSpeed, player.ACCELERATION*delta/player.jumpControlAcceleration)

	if player.is_on_floor():
		player.velocity.x = 0

	if player.is_on_ceiling():
		player.velocity.y = 0
	player.velocity.y += player.gravity * delta

	if player.attackTimer.is_stopped():
		player.attack_stopped()
		if player.is_on_floor():
			change_state.call_func("idle")
		elif not player.is_on_floor():
			change_state.call_func("fall")

	if player.damaged == true:
		change_state.call_func("damaged")

