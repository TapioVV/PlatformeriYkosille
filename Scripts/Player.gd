extends KinematicBody2D

class_name player

const ACCELERATION = 2800
const DEACCELERATION = 3800

export(float) var timeToJumpPeak = .3
export(int) var jumpHeight = 15
export(int) var jumpDistance = 150
export(float) var jumpBufferTime
export(float) var smallJump

#Less is more
export(int) var jumpControlDeacceleration
export(int) var jumpControlAcceleration 

onready var timer = get_node("JumpTimer")
var state
var state_machine
var velocity = Vector2.ZERO
var inputVector: float

var maxHorizontalSpeed: float
var gravity: float
var jumpSpeed: float
var smallJumpStart: bool = false
var jumpPressed: bool = false

func _ready():
	gravity = (2*jumpHeight)/pow(timeToJumpPeak,2)
	jumpSpeed = gravity * timeToJumpPeak
	maxHorizontalSpeed = jumpDistance / (2*timeToJumpPeak)
	state_machine = StateMachine.new()
	change_state("idle")

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_machine.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), self)
	state.name = "current_state"
	add_child(state)

func _physics_process(_delta):
	move_and_slide(velocity, Vector2.UP)
