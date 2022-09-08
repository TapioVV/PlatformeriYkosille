extends KinematicBody2D

export(float) var moveSpeed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var moveVector
# Called when the node enters the scene tree for the first time.
func _ready():
	moveVector = Vector2(moveSpeed, 50)
	pass # Replace with function body.

func _physics_process(delta):
	move_and_slide(moveVector)


func _on_RightWallChecker_body_entered(_body):
	moveVector.x = -moveSpeed
	pass # Replace with function body.


func _on_LeftWallChecker_body_entered(_body):
	moveVector.x = moveSpeed
	pass # Replace with function body.


func _on_RightGroundChecker_body_exited(_body):
	moveVector.x = -moveSpeed
	pass # Replace with function body.


func _on_LeftGroundChecker_body_exited(_body):
	moveVector.x = moveSpeed
	pass # Replace with function body.

func _on_get_hit():
	queue_free()
