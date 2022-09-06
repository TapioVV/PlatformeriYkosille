extends KinematicBody2D

class_name Player

const ACCELERATION = 2200
const DEACCELERATION = 3250

export(float) var timeToJumpPeak = .4
export(int) var jumpHeight = 10
export(int) var jumpDistance = 150

var state
var state_machine
var velocity = Vector2.ZERO
var inputVector

var maxHorizontalSpeed: float
var gravity: float
var jumpSpeed: float


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
	print(velocity.x)
	move_and_slide(velocity, Vector2.UP)
