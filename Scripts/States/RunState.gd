extends PlayerState

class_name RunState

func _ready():
	animation_player.play("AardvarkWalkAnim", 0 , player.runAnimationSpeed)
	player.velocity.y = 0

func _physics_process(delta):
	player.inputVector = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	if player.inputVector == 0:
		player.velocity.x = move_toward(player.velocity.x, 0, player.DEACCELERATION*delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, player.inputVector*player.maxHorizontalSpeed, player.ACCELERATION*delta)

	if player.inputVector == 1:
		player.emit_signal("looked_right")
		sprite.flip_h = false
	if player.inputVector == -1:
		player.emit_signal("looked_left")
		sprite.flip_h = true

	player.smallJumpStart = false

	if player.velocity.x >= -0.1 and player.velocity.x < 0.1:
		change_state.call_func("idle")
	if not player.is_on_floor():
		player.velocity.y = 0
		change_state.call_func("fall")
	if Input.is_action_just_pressed("Attack"):
		change_state.call_func("groundattack")
	if player.damaged == true:
		change_state.call_func("damaged")
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		change_state.call_func("jump")
		
		
