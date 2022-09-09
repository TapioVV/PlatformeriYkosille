extends Area2D

var hitBodies

var attacking: bool = false

signal enemyHit

onready var tongueHitBox = get_node("TongueHitBox")

func _on_PlayerBody_attacked():
	attacking = true

func _on_PlayerBody_attack_stopped():
	attacking = false

func _physics_process(_delta):
	if attacking == true:
		hitBodies = get_overlapping_bodies()
		if not hitBodies.empty():
			for n in hitBodies:
				if n.is_in_group("breakable"):
					n.queue_free()
				if n.is_in_group("enemy"):
					var enemy = n
					self.connect("enemyHit", enemy, "_on_get_hit")
					emit_signal("enemyHit")
					self.disconnect("enemyHit", enemy, "_on_get_hit")



func _on_PlayerBody_looked_left():
	tongueHitBox.rotation_degrees = 90


func _on_PlayerBody_looked_right():
	tongueHitBox.rotation_degrees = -90




