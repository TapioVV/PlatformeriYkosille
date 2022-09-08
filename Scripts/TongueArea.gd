extends Area2D

var hitBodies

var attacking: bool = false

onready var tongueHitBox = get_node("TongueHitBox")

func _on_PlayerBody_attacked():
	attacking = true

func _physics_process(delta):
	if attacking == true:
		hitBodies = get_overlapping_bodies()
		for n in hitBodies:
			if n.is_in_group("breakable"):
				n.queue_free()
			if hitBodies == null:
				break
			attacking = false



func _on_PlayerBody_looked_left():
	tongueHitBox.rotation_degrees = 90


func _on_PlayerBody_looked_right():
	tongueHitBox.rotation_degrees = -90

