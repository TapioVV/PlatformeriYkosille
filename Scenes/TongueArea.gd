extends Area2D

var hitBodies
onready var attackTimer = get_node("AttackTimer")

func _ready():
	pass # Replace with function body.


func _on_TongueArea_body_entered(body):
	if not attackTimer.is_stopped():
		hitBodies = get_overlapping_bodies()
		for n in hitBodies:
			if n.is_in_group("breakable"):
				n.queue_free()
