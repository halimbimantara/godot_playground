extends Actor

onready var frontRay: RayCast2D = $FrontRay
onready var groudRay: RayCast2D = $GroudRay


func _ready() -> void:
	input.x = 1

func _set_input():
	if frontRay.is_colliding() or not groudRay.is_colliding():
		input.x *= -1
