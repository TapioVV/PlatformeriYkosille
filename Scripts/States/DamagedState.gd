extends PlayerState

class_name DamagedState

func _ready():
	animation_player.play("AardvarkDamagedAnim")
	player.damageTimer.start(player.damageTime)
	player.damaged = false
	if sprite.is_flipped_h():
		player.velocity = Vector2(200, -player.jumpSpeed)
	if not sprite.is_flipped_h():
		player.velocity = Vector2(-200, -player.jumpSpeed)
	player.velocity.y = player.velocity.y / player.smallJump

func _physics_process(delta):
	if player.is_on_floor():
		player.velocity.x = 0
	if player.damageTimer.is_stopped():
		change_state.call_func("die")
#		if player.is_on_floor():
#			change_state.call_func("idle")
#		if not player.is_on_floor():
#			change_state.call_func("fall")

	player.velocity.y += player.gravity * delta
