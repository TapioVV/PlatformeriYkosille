extends Area2D

var hitBodies

func _ready():
	pass # Replace with function body.


func _on_TongueArea_body_entered(body):
	hitBodies = get_overlapping_bodies()
	for n in hitBodies:
		if n.is_in_group("breakable"):
			n.queue_free()
