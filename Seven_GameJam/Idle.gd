extends BaseState

func update_state(delta : float):
	if character.motion.y > 0:
		emit_signal("finished", "Falling")
	
	if character.motion.y < 0:
		emit_signal("finished", "Jump")
	
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"): 
		emit_signal("finished", "Move")


func handle_input(event : String):
	if event == "jump":
		emit_signal("finished", "Jump")
	else:
		emit_signal("finished", "Move")
