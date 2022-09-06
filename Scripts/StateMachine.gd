class_name StateMachine


var states


func _init():
	states = {
		"idle": IdleState,
		"run": RunState,
		"jump": JumpState,
		"fall": FallState,
	}


func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in FSM!")
