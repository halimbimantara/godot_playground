extends BaseState

export(int) var MAX_SPEED := 70
export(int) var ACCELERATION := 600

onready var timer: Timer = $Timer
var original_max_speed :int
var original_acceleration :int

func enter():
	.enter()
	accelerate_character()
	timer.start()


func exit():
	return_character_normal()
	.exit()


func update_state(delta : float):
	character.input_vector.x = character.flip_direction


func _on_Timer_timeout() -> void:
	emit_signal("finished", "Idle")


func accelerate_character():
	original_max_speed = character.MAX_SPEED
	original_acceleration = character.ACCELERATION
	
	character.MAX_SPEED = MAX_SPEED
	character.ACCELERATION = ACCELERATION
	
	character.animationPlayer.set_speed_scale(1.5)


func return_character_normal():
	character.MAX_SPEED = original_max_speed
	character.ACCELERATION = original_acceleration
	
	character.animationPlayer.set_speed_scale(1.0)
