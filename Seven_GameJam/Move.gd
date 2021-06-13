extends BaseState

func update_state(delta : float):
	if(Input.is_action_pressed("ui_left")): 
		character.input_vector = Vector2.LEFT
	
	elif(Input.is_action_pressed("ui_right")): 
		character.input_vector = Vector2.RIGHT
	
	else:
		character.input_vector = Vector2.ZERO
