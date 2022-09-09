extends PlayerState

class_name GroundAttackState


func _ready():
	animation_player.play("AardvarkAttackAnim")
	animation_player.play("AardvarkAttackAnim")
	player.velocity.x = 0
	player.attack()


func _physics_process(_delta):
	if player.attackTimer.is_stopped():
		player.attack_stopped()
		if player.is_on_floor():
			change_state.call_func("idle")
		elif not player.is_on_floor():
			change_state.call_func("fall")
	if player.damaged == true:
		change_state.call_func("damaged")
