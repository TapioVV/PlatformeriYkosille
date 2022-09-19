extends KinematicBody2D

enum STATE {IDLE, FOLLOW, GOBACK}

var _velocity = Vector2.ZERO

export var path_to_player = NodePath()
onready var player = get_node(path_to_player)
onready var agent_2d = $NavigationAgent2D
onready var _timer := $Timer
onready var mosquitoSprite = $MosquitoSprite

var state = STATE

var usedDelta

onready var startPosition = position

func _ready():
	_update_pathfinding()
	_timer.connect("timeout", self, "_update_pathfinding")
	state = STATE.IDLE
	pass # Replace with function body.



func _process(delta):
	usedDelta = delta
	match state:
		STATE.IDLE:
			null
		STATE.FOLLOW:
			_onFollow()
		STATE.GOBACK:
			null

func _on_get_hit():
	queue_free()

func _onFollow():
	if agent_2d.is_navigation_finished():
		return


	var target_global_position = agent_2d.get_next_location()
	var direction = global_position.direction_to(target_global_position)

	if target_global_position.x > position.x:
		mosquitoSprite.flip_h = true
	else:
		mosquitoSprite.flip_h = false

	var desired_velocity = direction * agent_2d.max_speed
	var steering = (desired_velocity - _velocity) * usedDelta * 4.0
	_velocity += steering

	_velocity = move_and_slide(_velocity)

func _update_pathfinding():
	agent_2d.set_target_location(player.global_position)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		state = STATE.FOLLOW
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
#	if body.is_in_group("player"):
#		state = STATE.IDLE
	pass # Replace with function body.
