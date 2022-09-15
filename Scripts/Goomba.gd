extends KinematicBody2D

export(float) var moveSpeed

onready var sprite = get_node("GoombaSprite")
onready var animationPlayer = get_node("AnimationPlayer")

var moveVector

func _ready():
	animationPlayer.play("GoombaWalkAnim")
	moveVector = Vector2(moveSpeed, 50)

func _physics_process(delta):
	move_and_slide(moveVector)


func _on_RightWallChecker_body_entered(_body):
	sprite.flip_h = false
	moveVector.x = -moveSpeed
	pass # Replace with function body.


func _on_LeftWallChecker_body_entered(_body):
	sprite.flip_h = true
	moveVector.x = moveSpeed
	pass # Replace with function body.


func _on_RightGroundChecker_body_exited(_body):
	sprite.flip_h = false
	moveVector.x = -moveSpeed
	pass # Replace with function body.


func _on_LeftGroundChecker_body_exited(_body):
	sprite.flip_h = true
	moveVector.x = moveSpeed
	pass # Replace with function body.


func _on_get_hit():
	queue_free()
