extends PlayerState

class_name IdleState

func _ready():
	player.velocity.x = 0

func _physics_process(_delta):
	if Input.is_action_pressed("Left"):
		move_left()
	elif Input.is_action_pressed("Right"):
		move_right()
	if Input.is_action_just_pressed("Jump") and player.is_on_floor():
		print("Jump")
		change_state.call_func("jump")
		print("Jumped")
	if not player.is_on_floor():
		change_state.call_func("fall")


func move_left():
	change_state.call_func("run")


func move_right():

	change_state.call_func("run")

