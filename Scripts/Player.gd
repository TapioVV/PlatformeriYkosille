extends KinematicBody2D

class_name player

const ACCELERATION = 2800
const DEACCELERATION = 3800

export(float) var timeToJumpPeak = .3
export(int) var jumpHeight = 15
export(int) var jumpDistance = 150
export(float) var jumpBufferTime
export(float) var smallJump
export(float) var attackTime

#Less is more
export(int) var jumpControlDeacceleration
export(int) var jumpControlAcceleration 

onready var jumpTimer = get_node("JumpTimer")
onready var attackTimer = get_node("TongueArea/AttackTimer")
onready var characterSprite = get_node("CharacterSprite")
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
	state.setup(funcref(self, "change_state"), self, characterSprite)
	state.name = "current_state"
	add_child(state)

func attack():
	attackTimer.start(attackTime)


func _physics_process(_delta):
	velocity.y = clamp(velocity.y, -1000, 600)
	move_and_slide(velocity, Vector2.UP)
