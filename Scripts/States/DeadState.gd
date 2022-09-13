extends PlayerState

class_name DeadState

var touchedFloor: bool = false


func _ready():
	pass

func _physics_process(delta):
	if touchedFloor == false:
		player.velocity.y += player.gravity * delta
		if player.is_on_floor(): 
			player.velocity.x = 0
			animation_player.play("AardvarkDeadOnGroundAnim")
			touchedFloor = true
	if not player.is_on_floor():
		animation_player.play("AardvarkDeadInAirAnim")
