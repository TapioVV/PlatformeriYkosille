extends PlayerState

class_name GroundAttackState


func _ready():
	player.velocity.x = 0
	player.attack()


func _physics_process(delta):
	if player.attackTimer.is_stopped():
		if player.is_on_floor():
			change_state.call_func("idle")
		elif not player.is_on_floor():
			change_state.call_func("fall")
