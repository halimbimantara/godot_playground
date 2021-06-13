extends "res://State.gd"

onready var coyoteTimer: Timer = $CoyoteTimer
var jumping := false


func update_state(delta : float):
	if character.is_on_floor() or coyoteTimer.time_left > 0:
		if !jumping:
			jumping = true
			character.motion.y = -character.JUMP_FORCE
	
	if(character.motion.y > 0):
		emit_signal("finished", "Falling")
	
	if(Input.is_action_pressed("ui_left")): 
		character.input_vector = Vector2.LEFT
	
	elif(Input.is_action_pressed("ui_right")): 
		character.input_vector = Vector2.RIGHT
	
	else:
		character.input_vector = Vector2.ZERO


func _on_StateMachine_state_changed(new_state: String) -> void:
	if new_state == "Falling":
			coyoteTimer.start()
	
	if new_state == "Idle" or new_state == "Move":
		jumping = false
