extends PlayerState

class_name IdleState

func _ready():
	animation_player.play("AardvarkIdleAnim")
	player.velocity.y = 0

func _physics_process(_delta):
	if Input.is_action_pressed("Left"):
		move_left()
	elif Input.is_action_pressed("Right"):
		move_right()
	if not player.is_on_floor():
		player.velocity.y = 0
		change_state.call_func("fall")
	if Input.is_action_just_pressed("Attack"):
		change_state.call_func("groundattack")
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		change_state.call_func("jump")
	if player.damaged == true:
		change_state.call_func("damaged")
	player.smallJumpStart = false


func move_left():
	change_state.call_func("run")


func move_right():
	change_state.call_func("run")




